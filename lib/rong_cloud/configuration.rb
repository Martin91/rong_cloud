require "logger"

module RongCloud
  # The main class to maintain connection settings
  #
  module Configuration
    # The default host to accept connections, use a https protocol
    DEFAULT_HOST = "https://api.cn.ronghub.com".freeze
    DEFAULT_TIMEOUT = 2
    DEFAULT_DEBUG_MODE = false

    module ModuleMethods
      attr_accessor :app_key, :app_secret
      attr_writer :host, :timeout, :debug_mode

      # Fetch the api host, the default is: https://api.cn.ronghub.com
      #
      def host
        @host || DEFAULT_HOST
      end

      def timeout
        @timeout || DEFAULT_TIMEOUT
      end

      def debug_mode
        @debug_mode || DEFAULT_DEBUG_MODE
      end
    end
    extend ModuleMethods
  end
end