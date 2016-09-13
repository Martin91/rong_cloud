require 'test_helper'

module RongCloud
  class SignatureTest < Minitest::Test
    include RongCloud::Signature

    def setup
      RongCloud.configure do |config|
        config.app_key = "uwd1c0sxdlx2"
        config.app_secret = "Y1W2MeFwwwRxa0"

        @nonce = 14314
        @timestamp = 1408706337
        @expected_sign = "e107e3819638b81a00383951d1d871197910ffe6"
      end
    end

    def test_signature
      signature = signature(@nonce, @timestamp)
      assert_equal @expected_sign, signature
    end

    def test_signed_headers
      Time.stub :now, Time.at(@timestamp) do
        def rand(args)
          @nonce
        end

        expected_headers = {
          'App-Key' => RongCloud::Configuration.app_key,
          'Nonce' => @nonce,
          'Timestamp' => @timestamp,
          'Signature' => @expected_sign
        }
        assert_equal expected_headers, signed_headers
      end
    end
  end
end