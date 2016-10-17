module RongCloud
  module Services
    module ChatroomTest
      def test_create_chatroom
        chatrooms = { 10001 => "name1", 10002 => "name2" }
        response = @service.create_chatroom(chatrooms)
        assert_equal 200, response["code"]
      end

      def test_join_chatroom_with_unexisted_chatroom_id
        error = assert_raises RongCloud::BadRequest do
          @service.join_chatroom(["user"], rand.to_s[2..8])
        end

        assert_equal "chatroomId is not exist.", error.message
      end

      def test_join_chatroom_with_multiple_users_less_than_50
        create_chatroom(10003)
        response = @service.join_chatroom(["user1", "user2", "user3"], 10003)
        assert_equal 200, response["code"]
      end

      def test_join_chatroom_with_multiple_users_greater_than_50
        create_chatroom(10004)
        users = 1.upto(51).map { |i| "user#{i}" }
        response = @service.join_chatroom(users, 10004)
        assert_equal 200, response["code"]
      end

      private
      def create_chatroom(id = "10000001")
        @service.create_chatroom({id => "super chatroom"})
      end
    end
  end
end