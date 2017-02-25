require 'test_helper'

module RongCloud
  module ServiceTestSetup
    def setup
      rong_cloud_configure_with_settings
      @service = RongCloud::Service.new
    end
  end
end