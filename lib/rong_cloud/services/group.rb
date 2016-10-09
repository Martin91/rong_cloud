module RongCloud
  module Services
    module Group
      # @param user_id [String] 用户在融云的 id
      # @param groups [Hash] 用户需要同步的群组信息，以群组 id 为键，以群组名称为值
      #
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
    end
  end
end