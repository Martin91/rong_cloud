require 'rong_cloud/service_test_setup'

module RongCloud
  module Services
    class MessageTest < Minitest::Test
      include RongCloud::ServiceTestSetup

      def test_send_private_message_with_single_to_user_id
        response = @service.send_private_message(1, 2, "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
      end

      def test_send_private_message_with_multiple_to_user_ids
        response = @service.send_private_message(1, [2, 3, 4], "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
      end

      def test_send_private_template_message_with_multiple_to_user_ids
        response = @service.send_private_template_message(1, [2, 3, 4], "RC:TxtMsg",
          { content: "hello {name}", extra: "nothing" },
          [
            {"{name}" => "user2"},
            {"{name}" => "user3"},
            {"{name}" => "user4"},
          ],
          pushContent: Array.new(3, "欢迎 {name}")
        )
        assert_equal 200, response["code"]
      end

      def test_send_private_template_message_with_multiple_to_user_ids_missing_push_content
        error = assert_raises RongCloud::MissingOptionError do
          @service.send_private_template_message(1, [2, 3], "RC:TxtMsg",
            { content: "hello {name}", extra: "nothing" },
            [
              {"{name}" => "user2"},
              {"{name}" => "user3"}
            ],
          )
        end

        assert_equal "pushContent is required for template messages", error.message
      end

      def test_send_private_message_with_options
        options = { pushContent: "hello", pushData: { shouldBeTrue: "true" } }
        response = @service.send_private_message(1, [2, 3, 4], "RC:TxtMsg", { content: "hello world", extra: "nothing" }, options)
        assert_equal 200, response["code"]
      end

      def test_send_system_message_with_single_to_user_id
        response = @service.send_system_message(1, 2, "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
      end

      def test_send_system_message_with_multiple_to_user_ids
        response = @service.send_system_message(1, [2, 3, 4], "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
      end

      def test_send_system_template_message_with_multiple_to_user_ids
        response = @service.send_system_template_message(1, [2, 3, 4], "RC:TxtMsg",
          { content: "hello {name}", extra: "nothing" },
          [
            {"{name}" => "user5"},
            {"{name}" => "user6"},
            {"{name}" => "user7"},
          ],
          pushContent: Array.new(3, "欢迎 {name}")
        )
        assert_equal 200, response["code"]
      end

      def test_send_system_message_with_options
        options = { pushContent: "hello", pushData: { shouldBeTrue: "true" } }
        response = @service.send_system_message(1, [2, 3, 4], "RC:TxtMsg", { content: "hello world", extra: "nothing" }, options)
        assert_equal 200, response["code"]
      end

      def test_send_group_message_with_single_to_group_id
        response = @service.send_group_message(1, 2, "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
      end

      def test_send_group_message_with_multiple_to_group_ids
        response = @service.send_group_message(1, [2, 3, 4], "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
      end

      def test_send_group_message_with_multiple_to_too_many_group_ids
        error = assert_raises RongCloud::BadRequest do
          @service.send_group_message(1, [2, 3, 4, 5], "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        end

        assert_equal "the number of toUserId should less than 3.", error.message
        assert_equal 1002, error.business_code
      end

      def test_send_group_message_with_options
        options = { pushContent: "hello", pushData: { shouldBeTrue: "true" } }
        response = @service.send_group_message(1, [2, 3, 4], "RC:TxtMsg", { content: "hello world", extra: "nothing" }, options)
        assert_equal 200, response["code"]
      end

      def test_send_discussion_message_with_single_to_discussion_id
        response = @service.send_discussion_message(1, 2, "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
      end

      def test_send_discussion_message_with_multiple_to_discussion_ids
        response = @service.send_discussion_message(1, [2, 3, 4], "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
      end

      def test_send_discussion_message_with_options
        options = { pushContent: "hello", pushData: { shouldBeTrue: "true" } }
        response = @service.send_discussion_message(1, [2, 3, 4], "RC:TxtMsg", { content: "hello world", extra: "nothing" }, options)
        assert_equal 200, response["code"]
      end

      def test_send_chatroom_message_with_single_to_chatroom_id
        response = @service.send_chatroom_message(1, 2, "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
      end

      def test_send_chatroom_message_with_multiple_to_chatroom_ids
        response = @service.send_chatroom_message(1, [2, 3, 4], "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
      end

      def test_send_chatroom_broadcast_message
        error = assert_raises RongCloud::RequestError do
          @service.send_chatroom_broadcast_message(1, "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        end
        # 未开通该服务，请到开发者管理后台开通或提交工单申请。
        assert_equal 1009, error.business_code
      end

      def test_send_broadcast_message
        response = @service.send_broadcast_message(1, "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
      end
    end
  end
end