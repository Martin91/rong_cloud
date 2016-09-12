require 'test_helper'

module RongCloud
  class ConnectionTest < Minitest::Test
    def test_app_key_settings_and_reading
      RongCloud::Configuration.app_key = "test_key"
      assert_equal "test_key", RongCloud::Configuration.app_key
    end

    def test_app_secret_settings_and_reading
      RongCloud::Configuration.app_secret = "test_secret"
      assert_equal "test_secret", RongCloud::Configuration.app_secret
    end

    def test_logger_setting_and_reading
      logger = ::Logger.new("rong_cloud.log")
      RongCloud::Configuration.logger = logger
      assert_equal logger, RongCloud::Configuration.logger
    end

    def test_default_host_and_setting_and_reading
      assert_equal "https://api.cn.ronghub.com", RongCloud::Configuration.host
      RongCloud::Configuration.host = "http://other.host.com"
      assert_equal "http://other.host.com", RongCloud::Configuration.host
    end
  end
end