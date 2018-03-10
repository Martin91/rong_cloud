require 'rong_cloud/service_test_setup'

module RongCloud
  module Services
    class ChatroomTest < Minitest::Test
      include RongCloud::ServiceTestSetup

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
        room = chatrooms.detect{ |chatroom| chatroom["chrmId"] == "10007" }
        assert_equal 2, chatrooms.count
        assert_equal "room7", room["name"]
      end

      def test_query_chatroom_with_unexisted_chatroom_ids
        chatrooms = @service.query_chatroom(%w(unexisted_chat1 unexisted_chat2))["chatRooms"]
        assert_equal [], chatrooms
      end

      def test_query_chatroom_users_with_count_1_and_order_1
        create_chatrooms({10009 => "room9"})
        @service.join_chatroom("user3", 10009)
        @service.join_chatroom("user4", 10009)

        users = @service.query_chatroom_users("10009", 1, "1")["users"]
        user = users.first
        assert_equal 1, users.count
        assert_equal "user3", user["id"]
      end

      def test_query_chatroom_users_with_count_1_and_order_2
        create_chatrooms({10009 => "room9"})
        @service.join_chatroom("user3", 10009)
        @service.join_chatroom("user4", 10009)

        users = @service.query_chatroom_users("10009", 1, "2")["users"]
        user = users.first
        assert_equal "user4", user["id"]
      end

      def test_query_chatroom_users_with_count_2
        create_chatrooms({10009 => "room9"})
        @service.join_chatroom("user3", 10009)
        @service.join_chatroom("user4", 10009)

        users = @service.query_chatroom_users("10009", 2)["users"]
        assert_equal 2, users.count
      end

      def test_query_chatroom_user_existence_for_existed_user
        create_chatrooms({10009 => "room9"})
        @service.join_chatroom("user3", 10009)

        response = @service.query_chatroom_user_existence("10009", "user3")
        assert response["isInChrm"]
      end

      def test_query_chatroom_user_existence_for_unexisted_user
        create_chatrooms({10009 => "room9"})
        @service.join_chatroom("user3", 10009)

        response = @service.query_chatroom_user_existence("10009", "unexisted_user_id")
        refute response["isInChrm"]
      end

      def test_query_chatroom_users_existence
        create_chatrooms({10009 => "room9"})
        @service.join_chatroom("user3", 10009)

        response = @service.query_chatroom_users_existence("10009", ["user3", "unexisted_user_id"])
        result = response["result"]

        user3_result = result.detect{ |r| r["userId"] == "user3" }
        assert_equal 1, user3_result["isInChrm"]

        unexisted_user_result = result.detect{ |r| r["userId"] == "unexisted_user_id" }
        assert_equal 0, unexisted_user_result["isInChrm"]
      end

      def test_gag_chatroom_user_flow
        create_chatrooms({10010 => "room10"})
        @service.join_chatroom("user5", 10010)

        response = @service.add_chatroom_gag_user(10010, "user5", 60)
        assert_equal 200, response["code"]

        response = @service.chatroom_gag_users(10010)
        assert_equal 200, response["code"]
        assert response["users"]

        response = @service.rollback_chatroom_gag_user(10010, "user5")
        assert_equal 200, response["code"]
      end

      def test_stop_chatroom_distribution
        response = @service.stop_chatroom_distribution(10011)
        assert_equal 200, response["code"]
      end

      def test_resume_chatroom_distribution
        response = @service.resume_chatroom_distribution(10011)
        assert_equal 200, response["code"]
      end

      def test_chatroom_whitelist_flow
        create_chatrooms({10011 => "room11"})
        @service.join_chatroom("user6", 10011)

        response = @service.add_chatroom_whitelist(10011, "user6")
        assert_equal 200, response["code"]
        response = @service.add_chatroom_whitelist(10011, ["user7", "user8"])
        assert_equal 200, response["code"]

        response = @service.whitelisted_chatroom_users(10011)
        assert_equal 200, response["code"]
        assert response["users"]

        response = @service.remove_chatroom_whitelist(10011, "user6")
        assert_equal 200, response["code"]
        response = @service.remove_chatroom_whitelist(10011, ["user7", "user8"])
        assert_equal 200, response["code"]
      end

      def test_ban_chatroom_user
        error = assert_raises RongCloud::RequestError do
          @service.ban_chatroom_user(1, 60)
        end

        # 聊天室全局禁言功能未开通。
        assert_equal 1009, error.business_code
      end

      def test_unban_chatroom_user
        error = assert_raises RongCloud::RequestError do
          @service.unban_chatroom_user(1)
        end

        # 聊天室全局禁言功能未开通。
        assert_equal 1009, error.business_code
      end

      def test_banned_chatroom_users
        error = assert_raises RongCloud::RequestError do
          @service.banned_chatroom_users
        end

        # 聊天室全局禁言功能未开通。
        assert_equal 1009, error.business_code
      end

      private
      def create_chatrooms(chatrooms = { 10000001 => "super chatroom"})
        @service.create_chatroom(chatrooms)
      end
    end
  end
end