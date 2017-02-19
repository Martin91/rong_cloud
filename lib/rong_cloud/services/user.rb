module RongCloud
  module Services
    # http://www.rongcloud.cn/docs/server.html#用户服务
    module User
      # Generate a new token to create a new RongCloud user
      #
      # @param user_id [String] user id
      # @param name [String] user name
      # @param portrait_uri [String] the url of user's avatar
      # @return [Hash] the response data
      #
      def get_token(user_id, name, portrait_uri)
        request("/user/getToken", {userId: user_id, name: name, portraitUri: portrait_uri})
      end

      def refresh_user(user_id, name = nil, portrait_uri = nil)
        params = { userId: user_id, name: name, portraitUri: portrait_uri }
        params.reject!{|key, value| value.nil?}

        request("/user/refresh", params)
      end

      def check_online(user_id)
        request("/user/checkOnline", { userId: user_id })
      end

      def block_user(user_id, minute)
        request("/user/block", { userId: user_id, minute: minute })
      end

      def unblock_user(user_id)
        request("/user/unblock", userId: user_id)
      end

      def blocked_users
        request("/user/block/query")
      end

      def blacklist_add(user_id, black_user_id)
        request("/user/blacklist/add", userId: user_id, blackUserId: black_user_id)
      end

      def blacklist_remove(user_id, black_user_id)
        request("/user/blacklist/remove", userId: user_id, blackUserId: black_user_id)
      end

      def blacklisted_users(user_id)
        request("/user/blacklist/query", userId: user_id)
      end
    end
  end
end