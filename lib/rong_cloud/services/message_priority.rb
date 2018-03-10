require 'rong_cloud/services/message/message_channel'

module RongCloud
  module Services
    # http://www.rongcloud.cn/docs/server.html#chatroom_message_priority
    module MessagePriority
      def add_chatroom_message_priority(object_name)
        request("/chatroom/message/priority/add", objectName: object_name)
      end

      def remove_chatroom_message_priority(object_name)
        request("/chatroom/message/priority/remove", objectName: object_name)
      end

      def chatroom_message_priorities
        request("/chatroom/message/priority/query")
      end

      def add_chatroom_message_whitelist(object_names)
        request("/chatroom/whitelist/add", objectnames: object_names)
      end

      def remove_chatroom_message_whitelist(object_names)
        request("/chatroom/whitelist/delete", objectnames: object_names)
      end

      def chatroom_message_whitelist
        request("/chatroom/whitelist/query")
      end
    end
  end
end