# frozen_string_literal: true
module TrustDock
  module Requests
    class Base
      attr_reader :location, :method, :limit, :params

      def initialize(args)
        @method = args[:method] || :get
        @location = args[:location] || ''
        @limit = args[:limit] || 10
        @params = args.fetch(:params)
      end

      def execute
        raise ArgumenrError, 'too many HTTP redirects' if limit.zero?
        uri = URI.parse(@location)

        req = case @method
              when :post
                req = Net::HTTP::Post.new(uri)
                req.body = params.to_json
                req
              else
                raise
              end

        req['Accept'] = 'application/json'
        req['Content-Type'] = 'application/json'
        req['Authorization'] = "Bearer #{ENV['TRUST_DOCK_API_TOKEN']}"

        res = Net::HTTP.start(
          uri.hostname,
          uri.port,
          use_ssl: uri.scheme == 'https'
        ) do |http|
          http.open_timeout = 5
          http.read_timeout = 10
          http.request(req)
        end

        JSON.parse(res.body).merge(
          status: res.code.to_i,
          message: error_message(res.code.to_i)
        )
      end

      def error_message(_code)
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end
    end
  end
end
