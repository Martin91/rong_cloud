require "logger"

module RongCloud
  # The main class to maintain connection settings
  #
  module Configuration
    # The default host to accept connections, use a https protocol
    DEFAULT_HOST = "https://api.cn.ronghub.com".freeze
    DEFAULT_TIMEOUT = 2

    module ModuleMethods
      attr_accessor :app_key, :app_secret
      attr_writer :host, :timeout

      # Fetch the api host, the default is: https://api.cn.ronghub.com
      #
      def host
        @host || DEFAULT_HOST
      end

      def timeout
        @timeout || DEFAULT_TIMEOUT
      end
    end
    extend ModuleMethods
  end
end