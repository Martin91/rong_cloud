require 'rong_cloud/services/message/message_channel'

module RongCloud
  module Services
    # http://www.rongcloud.cn/docs/server.html#chatroom_message_priority
    module MessagePriority
      def add_priority_message(object_name)
        request("/chatroom/message/priority/add", objectName: object_name)
      end
    end
  end
end