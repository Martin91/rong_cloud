require 'rong_cloud/service_test_setup'

module RongCloud
  module Services
    class ConversationNotificationTest < Minitest::Test
      include RongCloud::ServiceTestSetup

      def test_set_conversation_notification
        response = @service.set_conversation_notification(1, 2, 99, 1)
        assert_equal 200, response["code"]
      end

      def test_get_conversation_notification
        @service.set_conversation_notification(1, 2, 99, 1)
        response = @service.get_conversation_notification(1, 2, 99)
        assert_equal 1, response["isMuted"]

        @service.set_conversation_notification(1, 2, 99, 0)
        response = @service.get_conversation_notification(1, 2, 99)
        assert_equal 0, response["isMuted"]

        response = @service.get_conversation_notification(1, 2, "unexisted_id")
        assert_equal 0, response["isMuted"]
      end
    end
  end
end