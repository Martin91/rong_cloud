require 'rong_cloud/services/message/message_channel'

module RongCloud
  module Services
    module Message
      # 通用的发送消息方法
      # @param from_user_id [String] 消息发起人 id
      # @param target_id [String, Integer] 消息接收方，用户 id、群组 id、讨论组 id、聊天室 id 等
      # @param channel_name [String] 消息通道，表示单聊、系统、群组、讨论组、聊天室或者广播消息
      # @param object_name [String] 消息类型名称，内置消息类型或者自定义消息类型名称
      # @param [Hash] content 消息体，更多消息请看 http://www.rongcloud.cn/docs/server.html#内置消息类型表
      # @option content [Object] :content 消息体中的正文，如果为自定义消息，由消息消费方自行解析
      # @option content [Object] :extra 消息体中的附加信息，传递时为字符串，由消息消费方自行解析
      #
      # @param [Hash] options 额外选项，包含 pushContent 以及 pushData 等配置，所有支持选项根据各消息类型确定
      # @option options [String] :pushContent 推送通知显示的 Push 内容
      # @option options [Hash] :pushData 推送 payload
      #
      def send_message(from_user_id, target_id, channel_name, object_name, content, options = {})
        message_channel = MessageChannel.new(channel_name)
        params = { fromUserId: from_user_id, objectName: object_name, content: content.to_json }
        if message_channel.target_param_name
          params.merge!(message_channel.target_param_name => target_id)
        end

        params.merge!(options)
        request(message_channel.api_path, params)
      end

      def send_private_message(from_user_id, to_user_id, object_name, content, options = {})
        send_message(from_user_id, to_user_id, :private, object_name, content, options)
      end

      def send_system_message(from_user_id, to_user_id, object_name, content, options = {})
        send_message(from_user_id, to_user_id, :system, object_name, content, options)
      end

      def send_group_message(from_user_id, to_group_id, object_name, content, options = {})
        send_message(from_user_id, to_group_id, :group, object_name, content, options)
      end

      def send_discussion_message(from_user_id, to_discussion_id, object_name, content, options = {})
        send_message(from_user_id, to_discussion_id, :discussion, object_name, content, options)
      end
    end
  end
end