module RongCloud
  class UnsupportedMessageChannelName < ::StandardError;end
  class RequestError < ::StandardError
    attr_accessor :business_code
  end

  class BadRequest < RequestError;end
  class AuthenticationFailed < RequestError;end
  class RequestForbidden < RequestError;end
  class ResourceNotFound < RequestError;end
  class ExceedLimit < RequestError;end
  class TooManyRequests < RequestError;end
  class InternalServerError < RequestError;end
  class Timeout < RequestError;end

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