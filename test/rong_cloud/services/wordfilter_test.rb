require 'rong_cloud/service_test_setup'

module RongCloud
  module Services
    class WordfilterTest < Minitest::Test
      include RongCloud::ServiceTestSetup

      def test_add_wordfilter_with_single_word
        response = @service.add_wordfilter("敏感词")
        assert_equal 200, response["code"]
      end

      def test_delete_exist_wordfilter
        @service.add_wordfilter("hello")
        response = @service.delete_wordfilter("hello")
        assert_equal 200, response["code"]
      end

      def test_delete_unexist_wordfilter
        response = @service.delete_wordfilter("unexistedWord")
        assert_equal 200, response["code"]
      end

      def test_wordfilter_list
        @service.add_wordfilter("乱")
        response = @service.wordfilter_list
        words = response["words"].map{|word| word["word"]}
        assert_includes words, "乱"

        @service.delete_wordfilter("乱")
      end
    end
  end
end