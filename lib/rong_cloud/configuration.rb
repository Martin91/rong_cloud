require "logger"

module RongCloud
  module Configuration
    DEFAULT_HOST = "https://api.cn.ronghub.com".freeze

    module ModuleMethods
      attr_accessor :app_key, :app_secret, :host, :logger

      def host
        @host || DEFAULT_HOST
      end

      def logger
        @logger || default_logger
      end

      def default_logger
        @default_logger ||= ::Logger.new(STDOUT)
      end
    end
    extend ModuleMethods
  end
end