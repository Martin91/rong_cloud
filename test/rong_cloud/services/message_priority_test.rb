require 'rong_cloud/service_test_setup'

module RongCloud
  module Services
    class MessagePriorityTest < Minitest::Test
      include RongCloud::ServiceTestSetup

      def test_add_priority_message_with_single_object_name
        response = @service.add_priority_message("RC:CmdMsg")
        assert_equal 200, response["code"]
      end

      def test_add_priority_message_with_multiple_object_names
        response = @service.add_priority_message(["RC:CmdMsg", "RC:CmdNtf"])
        assert_equal 200, response["code"]
      end
    end
  end
end