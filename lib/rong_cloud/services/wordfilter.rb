module RongCloud
  module Services
    # http://www.rongcloud.cn/docs/server.html#敏感词服务
    module Wordfilter
      def add_wordfilter(word)
        request("/wordfilter/add", { word: word })
      end

      def delete_wordfilter(word)
        request("/wordfilter/delete", { word: word })
      end

      def wordfilter_list
        request("/wordfilter/list")
      end
    end
  end
end