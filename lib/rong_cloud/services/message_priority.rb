require 'rong_cloud/services/message/message_channel'

module RongCloud
  module Services
    # http://www.rongcloud.cn/docs/server.html#chatroom_message_priority
    module MessagePriority
      def add_chatroom_priority_message(object_name)
        request("/chatroom/message/priority/add", objectName: object_name)
      end

      def remove_chatroom_priority_message(object_name)
        request("/chatroom/message/priority/remove", objectName: object_name)
      end

      def chatroom_priority_messages
        request("/chatroom/message/priority/query")
      end
    end
  end
end