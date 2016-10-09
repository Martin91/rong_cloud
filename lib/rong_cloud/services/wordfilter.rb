module RongCloud
  module Services
    # 敏感词相关接口 http://www.rongcloud.cn/docs/server.html#敏感词服务
    module Wordfilter
      # 添加敏感词
      #
      # @param word [String] 敏感词
      #
      def add_wordfilter(word)
        request("/wordfilter/add", { word: word })
      end

      # 移除敏感词
      #
      def delete_wordfilter(word)
        request("/wordfilter/delete", { word: word })
      end

      # 查询已有敏感词的列表
      #
      def wordfilter_list
        request("/wordfilter/list")
      end
    end
  end
end