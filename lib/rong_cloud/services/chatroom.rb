module RongCloud
  module Services
    # 聊天室服务相关接口 http://www.rongcloud.cn/docs/server.html#聊天室服务
    module Chatroom
      # 创建聊天室，支持同时创建多个聊天室 http://www.rongcloud.cn/docs/server.html#创建聊天室_方法
      #
      # @param chatrooms [Hash] id 为 key，聊天室名称为 value 的 Hash 实例，多个 key-value 表示多个聊天室
      #
      def create_chatroom(chatrooms)
        params = {}
        chatrooms.each { |room_id, room_name| params["chatroom[#{room_id}]"] = room_name }

        request("/chatroom/create", params)
      end

      # 加入聊天室 http://www.rongcloud.cn/docs/server.html#加入聊天室_方法
      #
      # @param user_id [String, Array] 一个或多个用户 id
      # @param chatroom_id [String] 聊天室 id
      #
      def join_chatroom(user_id, chatroom_id)
        request("/chatroom/join", userId: user_id, chatroomId: chatroom_id)
      end
    end
  end
end