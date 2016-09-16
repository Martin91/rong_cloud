module RongCloud
  module Services
    module UserTest
      def test_get_token_without_user_id
        error = assert_raises RongCloud::BadRequest do
          @service.get_token(nil, nil, nil)
        end
        assert_equal 1002, error.business_code
        assert_equal "userId is required.", error.message
      end

      def test_get_token_without_name
        response = @service.get_token("user", nil, nil)
        assert response["token"]
      end

      def test_get_token_without_portrait_url
        response = @service.get_token("user", "User", nil)
        assert response["token"]
      end

      def test_get_token_with_all_params
        response = @service.get_token("user", "User", "fake_url")
        assert response["token"]
      end

      def test_get_token_with_chinese_name
        response = @service.get_token("user", "王二狗", "fake_url")
        assert response["token"]
      end

      def test_refresh_user_without_user_id
        error = assert_raises RongCloud::BadRequest do
          @service.refresh_user(nil, nil, nil)
        end
        assert_equal 1002, error.business_code
        assert_equal "userId is required.", error.message
      end

      def test_refresh_user_with_unexisted_user_id
        error = assert_raises RongCloud::BadRequest do
          @service.refresh_user("unexistedUserId", nil, nil)
        end
        assert_equal "userIdunexistedUserId is not exist.", error.message
        assert_equal 1002, error.business_code
      end

      def test_refresh_user_without_portrait_url
        response = @service.refresh_user("user", "User", nil)
        assert_equal 200, response["code"]
      end

      def test_refresh_user_with_all_params
        response = @service.refresh_user("user", "User", "fake_url")
        assert_equal 200, response["code"]
      end

      def test_refresh_user_with_chinese_name
        response = @service.refresh_user("user", "小李子", nil)
        assert_equal 200, response["code"]
      end

      def test_check_online_without_user_id
        error = assert_raises RongCloud::BadRequest do
          @service.check_online(nil)
        end
        assert_equal "userId is required.", error.message
        assert_equal 1002, error.business_code
      end

      def test_check_online_with_unexisted_user_id
        response = @service.check_online("unexistedUserId")
        assert_equal "0", response["status"]
      end

      def test_check_online_with_existed_user_id
        response = @service.check_online("user")
        assert_equal "0", response["status"]
      end

      def test_block_user_without_user_id
        error = assert_raises RongCloud::BadRequest do
          @service.block_user(nil, nil)
        end
        assert_equal "userId is required.", error.message
        assert_equal 1002, error.business_code
      end

      def test_block_user_without_minute
        @service.get_token("blocked_user", "Blocked", "fake_url")
        error = assert_raises RongCloud::BadRequest do
          @service.block_user("blocked_user", nil)
        end

        assert_equal "minute is required.", error.message
        assert_equal 1002, error.business_code
      end

      def test_block_user_without_unexisted_user_id
        response = @service.block_user("unexistedUserId", 3)
        assert_equal 200, response["code"]
      end

      def test_block_user_and_blocked_users_and_unblock_user
        @service.get_token("blocked_user2", "Blocked", "fake_url")
        response = @service.block_user("blocked_user2", 10)
        assert_equal 200, response["code"]

        users = @service.blocked_users["users"]
        user = users.detect{|object| object["userId"] == "blocked_user2"}
        assert user["blockEndTime"]

        response = @service.unblock_user("blocked_user2")
        assert 200, response["code"]
      end
    end
  end
end