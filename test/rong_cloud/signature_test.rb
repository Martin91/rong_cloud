require 'test_helper'

module RongCloud
  class SignatureTest < Minitest::Test
    include RongCloud::Signature

    def setup
      RongCloud.configure do |config|
        config.app_key = "uwd1c0sxdlx2"
        config.app_secret = "Y1W2MeFwwwRxa0"
      end
    end

    def test_signature
      signature = signature(14314, 1408706337)
      assert_equal "e107e3819638b81a00383951d1d871197910ffe6", signature
    end

    def test_signed_headers
      Time.stub :now, Time.at(1408706337) do
        def rand(args)
          14314
        end

        expected_headers = {
          'App-Key' => RongCloud::Configuration.app_key,
          'Nonce' => 14314,
          'Timestamp' => 1408706337,
          'Signature' => "e107e3819638b81a00383951d1d871197910ffe6"
        }
        assert_equal expected_headers, signed_headers
      end
    end
  end
end