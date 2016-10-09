require 'rong_cloud/configuration'
require 'rong_cloud/errors'
require 'rong_cloud/service'

# 融云 Ruby SDK 的全局命名空间
module RongCloud
  # 配置融云 Server 连接信息
  #
  def self.configure(&block)
    yield RongCloud::Configuration
  end
end