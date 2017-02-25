module RongCloud
  module Services
    module HistoryMessageTest
      def test_get_history
        date = "2014010101"
        response = @service.get_history(date)
        assert_equal 200, response['code']
        assert_equal date, response['date']
        assert_includes response, 'url'
      end
    end
  end
end