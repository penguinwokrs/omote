# frozen_string_literal: true
class AuthenticationMailer < ApplicationMailer
  default from: ENV['FROM_MAIL_ADDRESS']
  def notification(authentication)
    @authentication = authentication
    mail(to: ENV['TO_MAIL_ADDRESS'], subject: 'TRUST DOCKへ認証依頼を出しました')
  end

  def result(args)
    @authentication = args[:authentication]
    @result = args[:result]
    @denial_reasons = args[:denial_reasons]
    mail(to: ENV['TO_MAIL_ADDRESS'], subject: 'TRUST DOCKから認証結果が届きました')
  end
end
