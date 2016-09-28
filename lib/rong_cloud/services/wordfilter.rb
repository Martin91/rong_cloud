module RongCloud
  module Services
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