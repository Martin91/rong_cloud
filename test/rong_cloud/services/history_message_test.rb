require 'rong_cloud/service_test_setup'

module RongCloud
  module Services
    class HistoryMessageTest < Minitest::Test
      include RongCloud::ServiceTestSetup

      def test_get_history
        date = "2014010101"
        response = @service.get_history(date)
        assert_equal 200, response['code']
        assert_equal date, response['date']
        assert_includes response, 'url'
      end

      def test_delete_history
        date = "2014010101"
        response = @service.delete_history(date)
        assert_equal 200, response['code']
      end
    end
  end
end