# frozen_string_literal: true
class Authentication < ApplicationRecord
  attr_accessor :review_token

  belongs_to :prefecture

  validates :name, presence: true
  validates :dob, presence: true
  validates :prefecture_id, presence: true
  validates :address, presence: true
  validates :review_token, presence: true, on: :request_authentication

  before_save :set_trust_dock, if: :review_token?
  after_save -> { AuthenticationMailer.notification(self).deliver }, if: :review_token?

  enum status: { in_progress: 0, approved: 1, denied: 1 }
  enum gender: { male: 0, female: 1 }

  def set_trust_dock
    self.message_id = SecureRandom.uuid
    request_service = TrustDock::Requests::RequestAuthentication.new(
      location: 'https://api.test.trustdock.io/v1/review',
      params: params_of_trust_dock,
      method: :post
    )
    res = request_service.execute
    unless (200..299).cover?(res[:status])
      errors.add(:messages, res[:message])
      throw(:abort)
    end
    self.trust_dock_id = res['id']
    self.status = Authentication.statuses[:in_progress]
  end

  def params_of_trust_dock
    {
      document: {
        token: review_token
      },
      comparing_data: {
        fields: fields,
        data: {
          name: name,
          sex: gender,
          dob: dob.strftime('%Y-%m-%d'),
          address: full_address
        }
      }
    }
  end

  def full_address
    "#{prefecture.name}#{address}"
  end

  def fields
    %w(name sex dob address)
  end

  def review_token?
    review_token.present?
  end
end
