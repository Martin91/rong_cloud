module RongCloud
  class UnsupportedMessageChannelName < ::StandardError;end
  # Missing required settings for setup this gem
  class MissingOptionError < ::StandardError;end
  # The root exception for those related to RongCloud API
  class RequestError < ::StandardError
    # @!attribute [rw] business_code
    #   extended attribute, recording the return codes defined by RongCloud,
    #   refer to: http://www.rongcloud.cn/docs/server.html#api_code
    attr_accessor :business_code
  end

  class BadRequest < RequestError;end
  class AuthenticationFailed < RequestError;end
  class RequestForbidden < RequestError;end
  class ResourceNotFound < RequestError;end
  # Exceed group members limit
  class ExceedLimit < RequestError;end
  class TooManyRequests < RequestError;end
  class InternalServerError < RequestError;end
  class Timeout < RequestError;end

  # http://www.rongcloud.cn/docs/server.html#api
  # API 返回值
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