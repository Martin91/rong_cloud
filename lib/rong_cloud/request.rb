require 'net/http'
require 'json'
require 'rong_cloud/signature'

module RongCloud
  # 请求封装类，所有请求基于 Net::HTTP，自动支持 http 或者 https
  #
  module Request
    include Signature

    # 拼接请求的接口的路径
    #
    # @param path [String] 接口的相对路径，e.g. "/user/getToken" 或者 "user/getToken"，代码中自动处理开头的斜杠
    # @return [URI] 请求全路径生成的 URI 对象，自动追加 .json 格式扩展名
    #
    def get_uri(path)
      url = "#{RongCloud::Configuration.host}/#{path.gsub(/^\//, "")}"
      URI(url.end_with?(".json") ? url : "#{url}.json")
    end

    # 实例化请求对象
    #
    # @param uri [URI] 请求路径对象
    # @param params [Hash] 请求的参数，所有参数通过 form encoded data 方式发送
    # @return [Net::HTTP::Post] 请求的实例
    #
    def initialize_request(uri, params)
      req = Net::HTTP::Post.new(uri)
      req.set_form_data(params) if params.respond_to?(:map)
      signed_headers.each { |header, value| req[header] = value }

      req
    end

    # 解析响应数据，包含错误检测
    #
    # @param res [HTTPResponse] 响应结果的实例
    # @return [Hash] JSON 解析后的响应正文
    # @raise [RongCloud::BadRequest] 请求参数有误，缺失或者不正确等，详见官方文档
    #
    def handle_response(res)
      json = JSON.parse(res.body)
      case res
      when Net::HTTPOK
        json
      else
        error = (HTTP_CODE_TO_ERRORS_MAP[res.code] || RequestError).new(json["errorMessage"])
        error.business_code = json["code"]
        raise error
      end
    end

    # 执行请求
    # @param path [String] 请求 API 的相对路径
    # @param params [Hash] 请求的参数
    # @return [Hash] JSON 解析后的响应数据
    # @raise [RongCloud::BadRequest] 请求参数有误，缺失或者不正确等，详见官方文档
    def request(path, params = nil)
      uri = get_uri(path)
      req = initialize_request(uri, params)
      use_ssl = uri.scheme == 'https'
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: use_ssl) do |http|
        http.request(req)
      end

      handle_response(res)
    end
  end
end