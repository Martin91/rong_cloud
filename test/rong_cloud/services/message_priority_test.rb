require 'rong_cloud/service_test_setup'

module RongCloud
  module Services
    class MessagePriorityTest < Minitest::Test
      include RongCloud::ServiceTestSetup

      def test_chatroom_message_priority_flow
        response = @service.add_chatroom_message_priority("RC:CmdMsg")
        assert_equal 200, response["code"]

        response = @service.add_chatroom_message_priority(["RC:DizNtf", "RC:CmdNtf"])
        assert_equal 200, response["code"]

        response = @service.chatroom_message_priorities
        assert_equal ["RC:CmdMsg", "RC:DizNtf", "RC:CmdNtf"].sort, response["objectNames"].sort

        response = @service.remove_chatroom_message_priority(["RC:DizNtf", "RC:CmdNtf"])
        assert_equal 200, response["code"]

        response = @service.remove_chatroom_message_priority("RC:CmdMsg")
        assert_equal 200, response["code"]

        response = @service.chatroom_message_priorities
        assert_empty response["objectNames"]
      end

      def test_chatroom_message_whitelist_flow
        response = @service.add_chatroom_message_whitelist("RC:TxtMsg")
        assert_equal 200, response["code"]

        response = @service.add_chatroom_message_whitelist(["RC:ImgMsg", "RC:LBSMsg"])
        assert_equal 200, response["code"]

        response = @service.chatroom_message_whitelist
        whitelist = response["whitlistMsgType"].sort.select{ |i| !i.empty? }
        assert_equal ["RC:TxtMsg", "RC:ImgMsg", "RC:LBSMsg"].sort, whitelist

        response = @service.remove_chatroom_message_whitelist(["RC:ImgMsg", "RC:LBSMsg"])
        assert_equal 200, response["code"]

        response = @service.remove_chatroom_message_whitelist("RC:TxtMsg")
        assert_equal 200, response["code"]

        response = @service.chatroom_message_whitelist
        assert_equal [""], response["whitlistMsgType"]
      end
    end
  end
end