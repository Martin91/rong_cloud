module RongCloud
  module Services
    module GroupTest
      def test_sync_group
        response = @service.sync_group('user1', '1' => 'group1', '2' => 'group2')
        assert_equal 200, response['code']
      end

      def test_create_group_with_single_user_id
        response = @service.create_group('user1', '3', 'group3')
        assert_equal 200, response['code']
      end

      def test_create_group_with_multiple_user_id
        response = @service.create_group(%w(user1 user2 user3), '4', 'group4')
        assert_equal 200, response['code']
      end

      def test_create_group_without_group_id
        error = assert_raises RongCloud::BadRequest do
          @service.create_group('user1', nil, 'group3')
        end
        assert_equal 'groupId is required.', error.message
      end

      def test_create_group_without_group_name
        response = @service.create_group('user1', '5', nil)
        assert_equal 200, response['code']
      end

      def test_join_group_with_single_user_id
        response = @service.join_group('user1', '3', 'group3')
        assert_equal 200, response['code']
      end

      def test_join_group_with_multiple_user_id
        response = @service.join_group(%w(user1 user2 user3), '4', 'group4')
        assert_equal 200, response['code']
      end

      def test_join_group_without_group_id
        error = assert_raises RongCloud::BadRequest do
          @service.join_group('user1', nil, 'group3')
        end
        assert_equal 'groupId is required.', error.message
      end

      def test_join_group_without_group_name
        response = @service.join_group('user1', '5', nil)
        assert_equal 200, response['code']
      end
    end
  end
end