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
    end
  end
end