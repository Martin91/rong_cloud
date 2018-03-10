require 'rong_cloud/service_test_setup'

module RongCloud
  module Services
    class MessageRecallTest < Minitest::Test
      include RongCloud::ServiceTestSetup

      # conversationType = 1
      def test_message_recall_for_private_session
        response = @service.message_recall(1, 1, 2, "MESSAGE_UUID", (Time.now.to_f * 1000).to_i)
        assert_equal 200, response["code"]
      end

      # conversationType = 2
      def test_message_recall_for_discussion_session
        response = @service.message_recall(1, 2, 2, "MESSAGE_UUID", (Time.now.to_f * 1000).to_i)
        assert_equal 200, response["code"]
      end

      # conversationType = 3
      def test_message_recall_for_group_session
        response = @service.message_recall(1, 3, 2, "MESSAGE_UUID", (Time.now.to_f * 1000).to_i)
        assert_equal 200, response["code"]
      end
  	end
  end
end