require 'digest/sha1'

module RongCloud
  # a seperate module to perform api signature
  # http://www.rongcloud.cn/docs/server.html#通用_API_接口签名规则
  #
  module Signature
    # generate the final signature
    #
    # @param nonce [String] a random string with a whatever length
    # @param timestamp [String] timestamp, the elapsed seconds from 1970-01-01 00:00:00 UTC
    # @return [String] the final signature
    #
    def signature(nonce, timestamp)
      str = "#{RongCloud::Configuration.app_secret}#{nonce}#{timestamp}"
      Digest::SHA1.hexdigest(str)
    end

    # get required request headers
    # @note consist of the following request headers：
    #   App-Key
    #   Nonce
    #   Timestamp
    #   Signature
    # @return [Hash] headers represented as a Ruby hash
    def signed_headers
      nonce = rand(10**6)
      timestamp = Time.now.to_i
      signature = signature(nonce, timestamp)

      {
        'App-Key' => RongCloud::Configuration.app_key,
        'Nonce' => nonce,
        'Timestamp' => timestamp,
        'Signature' => signature
      }
    end
  end
end