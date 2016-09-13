require 'digest/sha1'

module RongCloud
  module Signature
    def signature(nonce, timestamp)
      str = "#{RongCloud::Configuration.app_secret}#{nonce}#{timestamp}"
      Digest::SHA1.hexdigest(str)
    end

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