# frozen_string_literal: true
class Authentication < ApplicationRecord
  attr_accessor :review_token

  belongs_to :prefecture

  validates :name, presence: true
  validates :dob, presence: true
  validates :address, presence: true
  validates :review_token, presence: true, on: :create

  before_save :set_trust_dock
  after_save -> { AuthenticationMailer.notification(self) }

  enum status: { unexecuted: 0, in_progress: 1, approved: 2, denied: 3 }

  def set_trust_dock
    request_service = RequestService.new(
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
    %w(name dob address)
  end
end
