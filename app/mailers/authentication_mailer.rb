# frozen_string_literal: true
class AuthenticationMailer < ApplicationMailer
  default from: ENV['FROM_MAIL_ADDRESS']

  after_action :set_message_id

  def notification(authentication)
    @authentication = authentication
    mail(
      to: ENV['TO_MAIL_ADDRESS'],
      subject: "TRUST DOCKへ認証依頼を出しました(#{@authentication.name})"
    )
  end

  def result(args)
    @authentication = args[:authentication]
    @result = args[:result]
    @denial_reasons = args[:denial_reasons]
    mail(
      to: ENV['TO_MAIL_ADDRESS'],
      subject: "TRUST DOCKから認証結果が届きました(#{@authentication.name})"
    )
  end

  def set_message_id
    headers['Message-ID'] = "#{@authentication.message_id}@#{ENV['DOMAIN']}"
  end
end
