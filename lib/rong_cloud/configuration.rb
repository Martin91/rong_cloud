require "logger"

module RongCloud
  # 管理融云 SDK 连接配置信息
  #
  module Configuration
    # 默认 API 服务器，使用 https
    DEFAULT_HOST = "https://api.cn.ronghub.com".freeze

    module ModuleMethods
      attr_accessor :app_key, :app_secret, :host, :logger

      # 获取目标主机，默认为 https://api.cn.ronghub.com
      #
      def host
        @host || DEFAULT_HOST
      end

      # 获取日志文件对象，默认日志文件为标准输出
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