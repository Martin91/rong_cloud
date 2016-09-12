module RongCloud
  module Configuration
    DEFAULT_CONFIGURATIONS = {
      log_file: "log/rongcloud.log",
      log_level: "DEBUG",
      host: "https://api.cn.ronghub.com"
    }

    module ModuleMethods
      attr_accessor :app_key, :app_secret, :host, :log_file, :log_level

      def self.extended(base)
        base.singleton_class.instance_eval do
          [:host, :log_file, :log_level].each do |config|
            define_method config do
              instance_variable_get("@#{config}") || DEFAULT_CONFIGURATIONS[config]
            end
          end
        end
      end
    end

    extend ModuleMethods
  end
end