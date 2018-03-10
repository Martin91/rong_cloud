module RongCloud
  module Services
    # http://www.rongcloud.cn/docs/server.html#sensitiveword
    module SensitiveWord
      def add_sensitive_word(word, replace_word = nil)
        arguments = { word: word }
        if replace_word.is_a?(String) && replace_word.length > 0
          arguments.merge!(replaceWord: replace_word)
        end

        request("/sensitiveword/add", arguments)
      end
      alias_method :add_wordfilter, :add_sensitive_word

      def delete_sensitive_word(word)
        request("/sensitiveword/delete", { word: word })
      end
      alias_method :delete_wordfilter, :delete_sensitive_word

      def sensitive_word_list
        request("/sensitiveword/list")
      end
      alias_method :wordfilter_list, :sensitive_word_list
    end
  end
end