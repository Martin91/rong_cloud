require 'rong_cloud/request'
require 'rong_cloud/services/user'

module RongCloud
  class Service
    include RongCloud::Request
    include RongCloud::Services::User
  end
end