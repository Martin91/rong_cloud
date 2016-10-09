module RongCloud
  module Services
    # 群组服务相关接口 http://www.rongcloud.cn/docs/server.html#群组服务
    module Group
      # 同步用户所属群组
      #
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

      # 创建群组
      #
      def create_group(user_id, group_id, group_name)
        request("/group/create", userId: user_id, groupId: group_id, groupName: group_name)
      end

      # 加入群组
      #
      def join_group(user_id, group_id, group_name)
        request("/group/join", userId: user_id, groupId: group_id, groupName: group_name)
      end

      # 退出群组
      #
      def quit_group(user_id, group_id)
        request("/group/quit", userId: user_id, groupId: group_id)
      end

      # 解散群组
      #
      def dismiss_group(user_id, group_id)
        request("/group/dismiss", userId: user_id, groupId: group_id)
      end

      # 刷新群组信息
      def refresh_group(group_id, group_name)
        request("/group/refresh", groupId: group_id, groupName: group_name)
      end

      # 查询群成员
      #
      def group_members(group_id)
        request("/group/user/query", groupId: group_id)
      end

      # 添加禁言群成员
      #
      def block_group_member(user_id, group_id, minute)
        request("/group/user/gag/add", userId: user_id, groupId: group_id, minute: minute)
      end

      # 移除禁言群成员
      #
      def unblock_group_member(user_id, group_id)
        request("/group/user/gag/rollback", userId: user_id, groupId: group_id)
      end

      # 查询被禁言群成员
      #
      def blocked_group_members(group_id)
        request("/group/user/gag/list", groupId: group_id)
      end
    end
  end
end