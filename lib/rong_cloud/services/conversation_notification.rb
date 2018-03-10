module RongCloud
  module Services
    # http://www.rongcloud.cn/docs/server.html#conversation_notification
    module ConversationNotification
      def set_conversation_notification(conversation_type, request_id, target_id, is_muted)
        request("/conversation/notification/set", {
          conversationType: conversation_type,
          requestId: request_id,
          targetId: target_id,
          isMuted: is_muted
        })
      end

      def get_conversation_notification(conversation_type, request_id, target_id)
        request("/conversation/notification/get", {
          conversationType: conversation_type,
          requestId: request_id,
          targetId: target_id
        })
      end
    end
  end
end