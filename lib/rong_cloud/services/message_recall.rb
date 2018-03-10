require 'rong_cloud/services/message/message_channel'

module RongCloud
  module Services
    # http://www.rongcloud.cn/docs/server.html#message_recall
    module MessageRecall
      def message_recall(from_user_id, conversation_type, target_id, message_uid, sent_time)
        request("/message/recall", {
          fromUserId: from_user_id,
          conversationType: conversation_type,
          targetId: target_id,
          messageUID: message_uid,
          sentTime: sent_time
        })
      end
    end
  end
end