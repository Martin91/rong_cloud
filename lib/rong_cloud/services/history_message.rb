module RongCloud
  module Services
    # http://www.rongcloud.cn/docs/server.html#消息历史记录服务
    module HistoryMessage
      # Get the download url for history messages within specified hour
      #
      # @param date [String] the date and hour represented in format "YYYYmmddHH"
      #
      def get_history(date)
        request "/message/history", { date: date }
      end
    end
  end
end