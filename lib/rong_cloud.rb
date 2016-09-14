require 'rong_cloud/configuration'
require 'rong_cloud/request'
require 'rong_cloud/errors'

module RongCloud
  # 配置融云 Server 连接信息
  #
  def self.configure(&block)
    yield RongCloud::Configuration
  end
end