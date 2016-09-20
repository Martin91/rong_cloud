module RongCloud
  module Services
    module User
      def get_token(user_id, name, portraitUri)
        request("/user/getToken", {userId: user_id, name: name, portraitUri: portraitUri})
      end

      def refresh_user(user_id, name = nil, portraitUri = nil)
        params = { userId: user_id, name: name, portraitUri: portraitUri }
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