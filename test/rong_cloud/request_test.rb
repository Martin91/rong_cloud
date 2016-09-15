require 'test_helper'

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
  end
end