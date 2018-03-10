module RongCloud
  module Services
    # http://www.rongcloud.cn/docs/server.html#history_message
    module HistoryMessage
      # Get the download url for history messages within specified hour
      #
      # @param date [String] the date and hour represented in format "YYYYmmddHH"
      #
      def get_history(date)
        request "/message/history", { date: date }
      end

      # Delete all history message whithin specified date and hour
      #
      # @param date [String] the date and hour represented in format "YYYYmmddHH"
      #
      def delete_history(date)
        request "/message/history/delete", { date: date }
      end
    end
  end
end