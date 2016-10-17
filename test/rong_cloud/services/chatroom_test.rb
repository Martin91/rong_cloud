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
        create_chatrooms({10003 => "room3"})
        response = @service.join_chatroom(["user1", "user2", "user3"], 10003)
        assert_equal 200, response["code"]
      end

      def test_join_chatroom_with_multiple_users_greater_than_50
        create_chatrooms({10004 => "room4"})
        users = 1.upto(51).map { |i| "user#{i}" }
        response = @service.join_chatroom(users, 10004)
        assert_equal 200, response["code"]
      end

      def test_destroy_chatroom_with_multiple_chatroom_ids_existed
        create_chatrooms({10005 => "room5", 10006 => "room6"})
        response = @service.destroy_chatroom([10005, 10006])
        assert_equal 200, response["code"]
      end

      def test_destroy_chatroom_with_multiple_chatroom_ids_unexisted
        response = @service.destroy_chatroom(%w(unexisted_chat1 unexisted_chat2))
        assert_equal 200, response["code"]
      end

      def test_query_chatroom_with_existed_chatroom_ids
        create_chatrooms({10007 => "room7", 10008 => "room8"})
        chatrooms = @service.query_chatroom(%w(10007 10008))["chatRooms"]
        chatroom_ids = chatrooms.map{ |chatroom| chatroom["chrmId"] }
        room = chatrooms.detect{ |chatroom| chatroom["chrmId"] == "10007" }
        assert_equal 2, chatrooms.count
        assert_equal "room7", room["name"]
      end

      def test_query_chatroom_with_unexisted_chatroom_ids
        chatrooms = @service.query_chatroom(%w(unexisted_chat1 unexisted_chat2))["chatRooms"]
        assert_equal [], chatrooms
      end

      private
      def create_chatrooms(chatrooms = { 10000001 => "super chatroom"})
        @service.create_chatroom(chatrooms)
      end
    end
  end
end