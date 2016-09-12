require 'test_helper'

class RondCloudTest < Minitest::Test
  def test_configure
    RongCloud.configure do |app|
      app.app_key = "KEY"
      app.app_secret = "SECRET"
      app.host = "HOST"
    end

    assert_equal "KEY", RongCloud::Configuration.app_key
    assert_equal "SECRET", RongCloud::Configuration.app_secret
    assert_equal "HOST", RongCloud::Configuration.host
  end
end