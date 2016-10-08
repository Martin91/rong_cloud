module RongCloud
  module Services
    module GroupTest
      def test_sync_group
        response = @service.sync_group('user1', '1' => 'group1', '2' => 'group2')
        assert_equal 200, response['code']
      end
    end
  end
end