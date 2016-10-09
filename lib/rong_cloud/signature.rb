require 'digest/sha1'

module RongCloud
  # 签名算法相关模块
  # http://www.rongcloud.cn/docs/server.html#通用_API_接口签名规则
  #
  module Signature
    # 生成签名串
    #
    # @param nonce [String] 参与签名的随机字串，无长度限制
    # @param timestamp [String] 时间戳，从 1970 年 1 月 1 日 0 点 0 分 0 秒开始到现在的秒数
    # @return [String] 签名完成之后的结果字串
    #
    def signature(nonce, timestamp)
      str = "#{RongCloud::Configuration.app_secret}#{nonce}#{timestamp}"
      Digest::SHA1.hexdigest(str)
    end

    # API 调用签名所需的请求头，包含签名等
    # @note 包含以下请求头：
    #   App-Key
    #   Nonce
    #   Timestamp
    #   Signature
    # @return [Hash] 签名所需请求头
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