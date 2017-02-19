module RongCloud
  module Services
    # http://www.rongcloud.cn/docs/server.html#群组服务
    module Group
      def sync_group(user_id, groups)
        params = {userId: user_id}
        groups.each do |id, name|
          params["group[#{id}]"] = name
        end

        request("/group/sync", params)
      end

      def create_group(user_id, group_id, group_name)
        request("/group/create", userId: user_id, groupId: group_id, groupName: group_name)
      end

      def join_group(user_id, group_id, group_name)
        request("/group/join", userId: user_id, groupId: group_id, groupName: group_name)
      end

      def quit_group(user_id, group_id)
        request("/group/quit", userId: user_id, groupId: group_id)
      end

      def dismiss_group(user_id, group_id)
        request("/group/dismiss", userId: user_id, groupId: group_id)
      end

      def refresh_group(group_id, group_name)
        request("/group/refresh", groupId: group_id, groupName: group_name)
      end

      def group_members(group_id)
        request("/group/user/query", groupId: group_id)
      end

      def block_group_member(user_id, group_id, minute)
        request("/group/user/gag/add", userId: user_id, groupId: group_id, minute: minute)
      end

      def unblock_group_member(user_id, group_id)
        request("/group/user/gag/rollback", userId: user_id, groupId: group_id)
      end

      def blocked_group_members(group_id)
        request("/group/user/gag/list", groupId: group_id)
      end
    end
  end
end