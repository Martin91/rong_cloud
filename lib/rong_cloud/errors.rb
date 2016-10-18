module RongCloud
  # 不支持的消息类型错误
  class UnsupportedMessageChannelName < ::StandardError;end
  # 缺少必传参数
  class MissingOptionError < ::StandardError;end
  # 与融云接口请求相关的基本错误类型，其他错误类型继承此类型
  class RequestError < ::StandardError
    # @!attribute [rw] business_code
    #   接口错误时的业务返回码，详见：http://www.rongcloud.cn/docs/server.html#API_方法返回值说明
    attr_accessor :business_code
  end

  # 错误请求
  class BadRequest < RequestError;end
  # 验证错误
  class AuthenticationFailed < RequestError;end
  # 被拒绝
  class RequestForbidden < RequestError;end
  # 资源不存在
  class ResourceNotFound < RequestError;end
  # 群上限
  class ExceedLimit < RequestError;end
  # 过多的请求
  class TooManyRequests < RequestError;end
  # 内部服务器错误
  class InternalServerError < RequestError;end
  # 内部服务器响应超时
  class Timeout < RequestError;end

  # 融云服务器响应状态码到 Ruby 错误类型的映射
  HTTP_CODE_TO_ERRORS_MAP = {
    "400" => BadRequest,
    "401" => AuthenticationFailed,
    "403" => RequestForbidden,
    "404" => ResourceNotFound,
    "405" => ExceedLimit,
    "429" => TooManyRequests,
    "500" => InternalServerError,
    "504" => Timeout
  }.freeze
end