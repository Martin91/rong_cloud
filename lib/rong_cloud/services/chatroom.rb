module RongCloud
  module Services
    # apis for chatroom http://www.rongcloud.cn/docs/server.html#聊天室服务
    module Chatroom
      # create a new chatroom，support creating multiple ones
      #   http://www.rongcloud.cn/docs/server.html#创建聊天室_方法
      #
      # @param chatrooms [Hash] created chatrooms
      #
      def create_chatroom(chatrooms)
        params = {}
        chatrooms.each { |room_id, room_name| params["chatroom[#{room_id}]"] = room_name }

        request("/chatroom/create", params)
      end

      # join a chatroom http://www.rongcloud.cn/docs/server.html#加入聊天室_方法
      #
      # @param user_id [String, Array] one or more user ids
      # @param chatroom_id [String] the id of the chatroom
      #
      def join_chatroom(user_id, chatroom_id)
        request("/chatroom/join", userId: user_id, chatroomId: chatroom_id)
      end

      # dismiss a chatroom http://www.rongcloud.cn/docs/server.html#销毁聊天室_方法
      #
      # @param chatroom_ids [String, Array] one or more chatroom ids
      #
      def destroy_chatroom(chatroom_ids)
        request("/chatroom/destroy", chatroomId: chatroom_ids)
      end

      # Query one or more chatroom details http://www.rongcloud.cn/docs/server.html#查询聊天室信息_方法
      #
      # @param chatroom_ids [String, Array] one or more chatroom ids
      #
      def query_chatroom(chatroom_ids)
        request("/chatroom/query", chatroomId: chatroom_ids)
      end

      # http://www.rongcloud.cn/docs/server.html#添加禁言聊天室成员_方法
      #
      def block_chatroom_user(chatroom_id, user_id, minute)
        request("/chatroom/user/gag/add", chatroomId: chatroom_id, userId: user_id, minute: minute)
      end

      # http://www.rongcloud.cn/docs/server.html#移除封禁聊天室成员_方法
      #
      def unblock_chatroom_user(chatroom_id, user_id)
        request("/chatroom/user/block/rollback", chatroomId: chatroom_id, userId: user_id)
      end

      # http://www.rongcloud.cn/docs/server.html#查询被封禁聊天室成员_方法
      #
      def blocked_chatroom_users(chatroom_id)
        request("/chatroom/user/block/list", chatroomId: chatroom_id)
      end

      # Fetch members list in a specified chatroom
      #
      # @param chatroom_id [String] chatroom id
      # @param count [String, Fixnum] the number of members to fetch, the maximum number is 500
      # @param order [String] order direction based on the time when users join the chatroom,
      #   1 for asc ordering, while 2 for desc ordering
      #
      def query_chatroom_users(chatroom_id, count, order = "1")
        request("chatroom/user/query", chatroomId: chatroom_id, count: count, order: order)
      end

      # http://www.rongcloud.cn/docs/server.html#聊天室消息停止分发_方法
      #
      def stop_chatroom_distribution(chatroom_id)
        request("/chatroom/message/stopDistribution", chatroomId: chatroom_id)
      end

      # http://www.rongcloud.cn/docs/server.html#聊天室消息恢复分发_方法
      #
      def resume_chatroom_distribution(chatroom_id)
        request("/chatroom/message/resumeDistribution", chatroomId: chatroom_id)
      end

      # 添加聊天室白名单成员 http://www.rongcloud.cn/docs/server.html#添加聊天室白名单成员_方法
      #
      def add_chatroom_whitelist(chatroom_id, user_id)
        request("/chatroom/user/whitelist/add", chatroomId: chatroom_id, userId: user_id)
      end

      # http://www.rongcloud.cn/docs/server.html#移除聊天室白名单成员_方法
      def remove_chatroom_whitelist(chatroom_id, user_id)
        request("/chatroom/user/whitelist/remove", chatroomId: chatroom_id, userId: user_id)
      end

      # http://www.rongcloud.cn/docs/server.html#查询聊天室白名单成员_方法
      def whitelisted_chatroom_users(chatroom_id)
        request("/chatroom/user/whitelist/query", chatroomId: chatroom_id)
      end
    end
  end
end