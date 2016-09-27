require 'rong_cloud/request'
require 'rong_cloud/services/user'
require 'rong_cloud/services/message'

module RongCloud
  class Service
    include RongCloud::Request
    include RongCloud::Services::User
    include RongCloud::Services::Message
  end
end