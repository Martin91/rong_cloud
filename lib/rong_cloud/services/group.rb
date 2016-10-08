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
    end
  end
end