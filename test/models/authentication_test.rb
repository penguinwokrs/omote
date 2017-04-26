# frozen_string_literal: true

require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase
  def test_valid_success
    authentication = authentications(:ryan_gosling)
    assert authentication.valid?
  end

  def test_call_set_trust_dock
    authentication = authentications(:ryan_gosling)
    authentication.review_token = SecureRandom.uuid
    mock = Minitest::Mock.new.expect(:call, 'Call method!')
    authentication.stub(:set_trust_dock, mock) do
      authentication.save(context: :request_authentication)
    end
    assert mock.verify, true
  end

  def test_call_mail_to
    authentication = authentications(:ryan_gosling)
    authentication.review_token = SecureRandom.uuid
    mock = Minitest::Mock.new.expect(:call, 'Call method!')

    assert_difference 'ActionMailer::Base.deliveries.count' do
      authentication.stub(:set_trust_dock, mock) do
        authentication.save
      end
    end
  end
end
