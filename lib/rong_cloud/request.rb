require 'net/http'
require 'json'
require 'rong_cloud/signature'

module RongCloud
  # Handle api request, based on Ruby's built-in Net::HTTP,
  # support both HTTP and HTTPS
  #
  module Request
    include Signature

    # @param path [String] The api endpoint
    # @param params [Hash] api params
    # @param content_type [Symbol] required formatting for request data, :form_data or :json
    # @return [Hash] the parsed response represented by JSON
    # @raise [RongCloud::BadRequest] when request params is invalid or other situations
    def request(path, params = nil, content_type = :form_data)
      uri = get_uri(path)
      req = initialize_request(uri, params, content_type)

      use_ssl = uri.scheme == 'https'
      timeout = RongCloud::Configuration.timeout
      request_options = { use_ssl: use_ssl, open_timeout: timeout, read_timeout: timeout }

      res = Net::HTTP.start(uri.hostname, uri.port, request_options) do |http|
        http.request(req)
      end

      handle_response(res)
    end

    private
    # construct the api endpoint url
    #
    # @param path [String] the relative path for api endpoint，e.g. "/user/getToken" or "user/getToken"
    # @return [URI] full url for the endpoint
    #
    def get_uri(path)
      url = "#{RongCloud::Configuration.host}/#{path.gsub(/^\//, "")}"
      URI(url.end_with?(".json") ? url : "#{url}.json")
    end

    # construct a new request
    #
    # @param uri [URI] the relative path for api endpoint
    # @param params [Hash] the request params
    # @param content_type [Symbol] required formatting for request data, :form_data or :json
    # @return [Net::HTTP::Post] the request object
    #
    def initialize_request(uri, params, content_type)
      req = Net::HTTP::Post.new(uri)
      signed_headers.each { |header, value| req[header] = value }

      case content_type
      when :form_data
        req.set_form_data(params) if params.respond_to?(:map)
      when :json
        req.body = params.to_json
        req["Content-Type"] = "application/json"
      end

      req
    end

    # parse the raw response
    #
    # @param res [HTTPResponse] the response
    # @return [Hash] response data parsed as JSON
    # @raise [RongCloud::BadRequest] when params are invalid or other situations
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
  end
end