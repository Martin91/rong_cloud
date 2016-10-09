module RongCloud
  module Services
    # 用户相关接口 http://www.rongcloud.cn/docs/server.html#用户服务
    module User
      # 获取 Token，即创建融云用户
      #
      # @param user_id [String] 用户 Id，最大长度 64 字节。是用户在 App 中的唯一标识码，必须保证在同一个 App 内不重复，重复的用户 Id 将被当作是同一用户
      # @param name [String] 用户名称，最大长度 128 字节。用来在 Push 推送时显示用户的名称。
      # @param portrait_uri [String] 用户头像 URI，最大长度 1024 字节。用来在 Push 推送时显示用户的头像。
      # @return [Hash] 请求响应结果数据
      #
      def get_token(user_id, name, portrait_uri)
        request("/user/getToken", {userId: user_id, name: name, portraitUri: portrait_uri})
      end

      # 刷新用户信息
      #
      def refresh_user(user_id, name = nil, portrait_uri = nil)
        params = { userId: user_id, name: name, portraitUri: portrait_uri }
        params.reject!{|key, value| value.nil?}

        request("/user/refresh", params)
      end

      # 检查用户在线状态
      #
      def check_online(user_id)
        request("/user/checkOnline", { userId: user_id })
      end

      # 封禁用户
      # @param user_id [String] 用户在融云的用户 id
      # @param minute [Integer] 封禁时长
      #
      def block_user(user_id, minute)
        request("/user/block", { userId: user_id, minute: minute })
      end

      # 解除用户封禁
      #
      def unblock_user(user_id)
        request("/user/unblock", userId: user_id)
      end

      # 查询被封禁用户列表
      #
      def blocked_users
        request("/user/block/query")
      end

      # 添加用户到黑名单
      #
      def blacklist_add(user_id, black_user_id)
        request("/user/blacklist/add", userId: user_id, blackUserId: black_user_id)
      end

      # 从黑名单中移除用户
      #
      def blacklist_remove(user_id, black_user_id)
        request("/user/blacklist/remove", userId: user_id, blackUserId: black_user_id)
      end

      # 获取某用户的黑名单列表
      #
      def blacklisted_users(user_id)
        request("/user/blacklist/query", userId: user_id)
      end
    end
  end
end