# frozen_string_literal: true
module TrustDock
  module Requests
    class RequestAuthentication < TrustDock::Requests::Base
      def error_message(code)
        case code
        when 400..499
          '認証依頼に失敗しました。omoteの運営会社へご連絡ください。'
        when 500..599
          '外部サービスとの連携に失敗しました。omoteの運営会社にご連絡ください。'
        end
      end
    end
  end
end
