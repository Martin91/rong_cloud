module RongCloud
  module Services
    module MessageTest
      def test_send_private_message_with_single_to_user_id
        response = @service.send_private_message(1, 2, "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
      end

      def test_send_private_message_with_multiple_to_user_ids
        response = @service.send_private_message(1, [2, 3, 4], "RC:TxtMsg", { content: "hello world", extra: "nothing" })
        assert_equal 200, response["code"]
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

      def test_send_system_message_with_options
        options = { pushContent: "hello", pushData: { shouldBeTrue: "true" } }
        response = @service.send_system_message(1, [2, 3, 4], "RC:TxtMsg", { content: "hello world", extra: "nothing" }, options)
        assert_equal 200, response["code"]
      end
    end
  end
end