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
          @service.refresh_user("user2", nil, nil)
        end
        assert_equal "userIduser2 is not exist.", error.message
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
        response = @service.check_online("user2")
        assert_equal "0", response["status"]
      end

      def test_check_online_with_existed_user_id
        response = @service.check_online("user")
        assert_equal "0", response["status"]
      end
    end
  end
end