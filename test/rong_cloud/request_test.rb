require 'test_helper'
require 'byebug'

module RongCloud
  class RequestTest < Minitest::Test
    include RongCloud::Request

    def setup
      RongCloud.configure do |config|
        $settings.each do |setting, value|
          config.send("#{setting}=", value)
        end
      end
    end

    def test_get_uri_path_end_with_json_format
      uri = get_uri("users.json")
      assert_equal "/users.json", uri.path
      assert_equal "api.cn.ronghub.com", uri.host
    end

    def test_get_uri_path_not_end_with_json_format
      uri = get_uri("users")
      assert_equal "/users.json", uri.path
      assert_equal "api.cn.ronghub.com", uri.host
    end

    def test_request_with_invalid_app_key
      RongCloud::Configuration.app_key = "xxx"
      error = assert_raises RongCloud::BadRequest do
        request("/user/getToken", {userId: 'user', name: "User"})
      end
      assert_equal "invalid App-Key.", error.message
      assert_equal 1002, error.business_code
    end

    def test_request_with_invalid_app_secret
      RongCloud::Configuration.app_secret = "xxx"
      error = assert_raises RongCloud::AuthenticationFailed do
        request("/user/getToken", {userId: 'user', name: "User"})
      end
      assert_equal "签名错误，请检查。", error.message
      assert_equal 1004, error.business_code
    end

    def test_request_with_missing_required_field
      error = assert_raises RongCloud::BadRequest do
        request("/user/getToken")
      end
      assert_equal "userId is required.", error.message
      assert_equal 1002, error.business_code
    end

    def test_request_with_valid_params
      response = request("/user/getToken", { userId: 'user', name: "User", portraitUri: "uri" })
      assert_equal 200, response["code"]
      assert_equal "user", response["userId"]
      assert response["token"]
    end
  end
end