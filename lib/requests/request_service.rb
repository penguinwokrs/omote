# frozen_string_literal: true
class RequestService
  attr_reader :location, :method, :limit, :params

  def initialize(args)
    @method = args[:method] || :get
    @location = args[:location] || ''
    @limit = args[:limit] || 10
    @params = args.fetch(:params)
  end

  def execute
    raise ArgumenrError, 'too many HTTP redirects' if limit == 0
    uri = URI.parse(@location)

    req = case @method
          when :post
            req = Net::HTTP::Post.new(uri)
            req.body = params.to_json
            req['Accept'] = 'application/json'
            req['Content-Type'] = 'application/json'
            req['Authorization'] = "Bearer #{ENV['TRUST_DOCK_API_TOKEN']}"
            req
          when :patch
          when :delete
          else
            Net::HTTP::Get.new(uri)
            raise
          end

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.open_timeout = 5
      http.read_timeout = 10
      http.request(req)
    end

    case res.code.to_i
    when 200..299
      JSON.parse(res.body)
    when 400
      # クライアントに返却(validateで対応するので、サーバエラー)
    when 401
      # サーバーエラー
    when 404
      # サーバーエラー?(テストにより検証できるか)
    when 405
      # サーバーエラー
    when 413
      # サーバーエラー(画像？)
    when 500
      # サーバーエラー(API)
    when 502
      # サーバーエラー(API)
    when 503
      # サーバーエラー(API)
    else
      JSON.parse(res.body)
    end
  end
end
