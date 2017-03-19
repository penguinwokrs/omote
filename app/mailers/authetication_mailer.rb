# frozen_string_literal: true
class AutheticationMailer < ApplicationMailer
  default from: 'any.developer.rb@gmail.com'
  # FIXME: メールアドレスをenvに移す
  def notification(authentication)
    @authentication = authentication
    mail(to: 'any.developer.rb@gmail.com', title: 'TRUST DOCKへ認証依頼を出しました')
  end

  def result(args)
    @authentication = args[:authentication]
    @result = args[:result]
    @denial_reasons = args[:denial_reasons]
    mail(to: 'any.developer.rb@gmail.com', title: 'TRUST DOCKから認証結果が届きました')
  end
end
