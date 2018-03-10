require 'rong_cloud/service_test_setup'

module RongCloud
  module Services
    class SensitiveWordTest < Minitest::Test
      include RongCloud::ServiceTestSetup

      def test_add_sensitive_word_with_single_word
        response = @service.add_sensitive_word("敏感词")
        assert_equal 200, response["code"]
      end

      def test_add_sensitive_word_with_single_word_and_replace_word
        response = @service.add_sensitive_word("敏感词", "***")
        assert_equal 200, response["code"]
      end

      def test_delete_exist_sensitive_word
        @service.add_sensitive_word("hello")
        response = @service.delete_sensitive_word("hello")
        assert_equal 200, response["code"]
      end

      def test_delete_unexist_sensitive_word
        response = @service.delete_sensitive_word("unexistedWord")
        assert_equal 200, response["code"]
      end

      def test_sensitive_word_list
        @service.add_sensitive_word("乱")
        response = @service.sensitive_word_list
        words = response["words"].map{|word| word["word"]}
        assert_includes words, "乱"

        @service.delete_sensitive_word("乱")
      end
    end
  end
end