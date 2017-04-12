# frozen_string_literal: true

require 'test_helper'

class RequestServiceTest < ActiveSupport::TestCase
  test 'it return response json what execute' do
    RESULT = { id: 1, created_at: Time.current }.freeze
    request_service = RequestService.new(
      location: 'https://api.test.trustdock.io/v1/review',
      params:     {
        "document": {
          "token": review_token
        },
        "comparing_data": {
          "fields": %w[name dob address gender],
          "data": {
            "name": name,
            "birth": birth.strftime('%Y-%m-%d'),
            "address": "#{prefecture.name}#{address}",
            "gender": gender
          }
        }
      },
      method: :post
    )

    request_service.stub(:execute, RESULT) do
      res = request_service.execute
      assert_equal res[:status], 202
      assert_equal res.to_json, RESULT
    end
  end
end
