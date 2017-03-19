# frozen_string_literal: true
class ResponseService
  # FIXME: class name
  attr_accessor :authentication, :params

  def initialize(args)
    @authentication = args[:authentication]
    @params = args[:params]
  end

  def update
    @authentication.update!(status: @params['result'])
    AuthenticationMailer.result(
      authetication: @authentication,
      result: @params['result'],
      denial_reasons: parse_denied_messages
    ).deliver
  rescue
    # FIXME: 例外処理
    false
  end

  def parse_denied_reasons
    @params['review'].dig('denial_reasons').map do |h|
      { code: h['code'], message: h['message'] }
    end
  end
end
