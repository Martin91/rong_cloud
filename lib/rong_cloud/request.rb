require 'net/http'
require 'json'
require 'rong_cloud/signature'

module RongCloud
  module Request
    include Signature

    def get_uri(path)
      url = "#{RongCloud::Configuration.host}/#{path.gsub(/^\//, "")}"
      URI(url.end_with?(".json") ? url : "#{url}.json")
    end

    def initialize_request(uri, params)
      req = Net::HTTP::Post.new(uri)
      req.set_form_data(params)
      signed_headers.each { |header, value| req[header] = value }

      req
    end

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

    def request(path, params)
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