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
    end
  end
end