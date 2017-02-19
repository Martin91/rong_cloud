require 'rong_cloud/configuration'
require 'rong_cloud/errors'
require 'rong_cloud/service'
require 'core_ext/array'

# global namespace for this SDK
module RongCloud
  # Use this method for connection settings
  #
  def self.configure(&block)
    yield RongCloud::Configuration
  end
end