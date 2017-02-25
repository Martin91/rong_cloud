require 'test_helper'
require 'rong_cloud/services/user_test'
require 'rong_cloud/services/message_test'
require 'rong_cloud/services/wordfilter_test'
require 'rong_cloud/services/group_test'
require 'rong_cloud/services/chatroom_test'
require 'rong_cloud/services/history_message_test'

module RongCloud
  class ServiceTest < Minitest::Test
    include RongCloud::Services::UserTest
    include RongCloud::Services::MessageTest
    include RongCloud::Services::WordfilterTest
    include RongCloud::Services::GroupTest
    include RongCloud::Services::ChatroomTest
    include RongCloud::Services::HistoryMessageTest

    def setup
      rong_cloud_configure_with_settings
      @service = RongCloud::Service.new
    end
  end
end