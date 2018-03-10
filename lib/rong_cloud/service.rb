require 'rong_cloud/request'
require 'rong_cloud/services/user'
require 'rong_cloud/services/message'
require 'rong_cloud/services/message_recall'
require 'rong_cloud/services/wordfilter'
require 'rong_cloud/services/group'
require 'rong_cloud/services/chatroom'
require 'rong_cloud/services/history_message'

module RongCloud
  class Service
    include RongCloud::Request
    include RongCloud::Services::User
    include RongCloud::Services::Message
    include RongCloud::Services::MessageRecall
    include RongCloud::Services::HistoryMessage
    include RongCloud::Services::Wordfilter
    include RongCloud::Services::Group
    include RongCloud::Services::Chatroom
  end
end