# frozen_string_literal: true
require 'openssl'

module TrustDock
  class DigitalSignature
    def initialize(req)
      @req = req
    end

    def secure_compare
      digest     = OpenSSL::Digest.new('sha256')
      secret_key = ENV['WEBHOOK_SECRET_KEY']
      signature  = "sha256=#{OpenSSL::HMAC.hexdigest(digest, secret_key, @req.body.read)}"

      if Rack::Utils.secure_compare(signature, @req.headers['HTTP_X_WEBHOOK_SIGNATURE'])
        return { status: 200 }
      else
        return { status: 500, message: 'Invalid Webhook Signature' }
      end
    end
  end
end
