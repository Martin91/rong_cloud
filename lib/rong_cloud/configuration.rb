require "logger"

module RongCloud
  # The main class to maintain connection settings
  #
  module Configuration
    # The default host to accept connections, use a https protocol
    DEFAULT_HOST = "https://api.cn.ronghub.com".freeze

    module ModuleMethods
      attr_accessor :app_key, :app_secret, :host, :logger

      # Fetch the api host, the default is: https://api.cn.ronghub.com
      #
      def host
        @host || DEFAULT_HOST
      end

      # Fetch the logger, the default is STDOUT
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