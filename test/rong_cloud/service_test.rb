require 'test_helper'
require 'rong_cloud/services/user_test'

module RongCloud
  class ServiceTest < Minitest::Test
    include RongCloud::Services::UserTest

    def setup
      rong_cloud_configure_with_settings
      @service = RongCloud::Service.new
    end
  end
end