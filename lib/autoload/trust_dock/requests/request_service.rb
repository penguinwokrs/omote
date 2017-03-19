# frozen_string_literal: true
class RequestService
  # FIXME: class name
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
          when :patch
            # FIXME:  動作未確認
            Net::HTTP::Patch.new(uri)
          when :delete
            # FIXME:  動作未確認
            Net::HTTP::Delete.new(uri)
          else
            # FIXME:  動作未確認
            Net::HTTP::Get.new(uri)
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

  def error_message(code)
    # FIXME: メッセージの見直し
    case code
    when 400..499
      '認証依頼に失敗しました。omoteの運営会社へご連絡ください。'
    when 500..599
      '外部サービスとの連携に失敗しました。omoteの運営会社にご連絡ください。'
    end
  end
end
