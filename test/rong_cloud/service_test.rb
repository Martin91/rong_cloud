require 'test_helper'
require 'rong_cloud/services/user_test'
require 'rong_cloud/services/message_test'
require 'rong_cloud/services/wordfilter_test'

module RongCloud
  class ServiceTest < Minitest::Test
    include RongCloud::Services::UserTest
    include RongCloud::Services::MessageTest
    include RongCloud::Services::WordfilterTest

    def setup
      rong_cloud_configure_with_settings
      @service = RongCloud::Service.new
    end
  end
end