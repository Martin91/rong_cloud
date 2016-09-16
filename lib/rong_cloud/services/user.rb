require 'rong_cloud/request'

module RongCloud
  module Services
    module User
      def get_token(userId, name, portraitUri)
        request("/user/getToken", {userId: userId, name: name, portraitUri: portraitUri})
      end

      def refresh_user(userId, name = nil, portraitUri = nil)
        params = { userId: userId, name: name, portraitUri: portraitUri }
        params.reject!{|key, value| value.nil?}

        request("/user/refresh", params)
      end

      def check_online(userId)
        request("/user/checkOnline", { userId: userId })
      end

      def block_user(userId, minute)
        request("/user/block", { userId: userId, minute: minute })
      end

      def unblock_user(userId)
        request("/user/unblock", userId: userId)
      end

      def blocked_users
        request("/user/block/query")
      end
    end
  end
end