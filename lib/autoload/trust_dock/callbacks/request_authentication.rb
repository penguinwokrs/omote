# frozen_string_literal: true
module TrustDock
  module Callbacks
    class RequestAuthentication < TrustDock::Callbacks::Base
      def update
        @authentication.update!(status: Authentication.statuses[@params['result']])
        AuthenticationMailer.result(
          authentication: @authentication,
          result: @params['result'],
          denial_reasons: parse_denied_reasons
        ).deliver
      rescue
        false
      end

      def parse_denied_reasons
        return [] if @params[:review]&.dig(:denial_reasons).blank?
        @params[:review].dig(:denial_reasons).map do |h|
          { code: h[:code], message: h[:message] }
        end
      end
    end
  end
end
