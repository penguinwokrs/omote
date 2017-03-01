# frozen_string_literal: true
class Authentication < ApplicationRecord
  belongs_to :prefecture

  attr_accessor :review_token
  validates :name, presence: true
  validates :dob, presence: true
  validates :address, presence: true
  validates :review_token, presence: true, on: :create

  before_create :set_trust_dock

  enum status: { unexecuted: 0, in_progress: 1, approved: 2, denied: 3 }

  def set_trust_dock
    request_service = RequestService.new(
      location: 'https://api.test.trustdock.io/v1/review',
      params: params_of_trust_dock,
      method: :post
    )
    res = request_service.execute
    self.trust_dock_id = res['id']
  end

  def params_of_trust_dock
    {
      "document": {
        "token": review_token
      },
      "comparing_data": {
        "fields": %w(name dob address),
        "data": {
          "name": name,
          "dob": dob.strftime('%Y-%m-%d'),
          "address": "#{prefecture.name}県#{address}"
        }
      }
    }
  end

  def parse_error_json(res)
    JSON.parse(res)
  end
end
