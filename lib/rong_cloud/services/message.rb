require 'rong_cloud/services/message/message_channel'

module RongCloud
  module Services
    # http://www.rongcloud.cn/docs/server.html#message
    module Message
      # General method to send messages
      # @param from_user_id [String] sender id
      # @param target_id [String, Integer] receiver id，might be a user id,
      #   group id, discussion group id or chatroom id
      # @param channel_name [String] the message channel
      # @param object_name [String] message type name, could be built-in or custome names
      # @param [Hash] content Message object，view http://www.rongcloud.cn/docs/server.html#内置消息类型表 to learn more
      # @option content [Object] :content the body of message
      # @option content [Object] :extra the extras of message，passed as a string
      #   and should be parsed by the message consumer
      # @option content [Object] :user the informations for user, see: http://www.rongcloud.cn/docs/server.html#user_info
      # @param args [Array] additional params，when it includes only one param,
      #   the args is a options; when 2 params, the first one is the `values` of
      #   a template message, the the last one is a options
      # @param [Hash] options options includes pushContent and pushData and so on,
      #   total supported options determined by the message type
      # @option options [String] :pushContent push content
      # @option options [Hash] :pushData push data as payload
      # @option options [Hash] :verifyBlacklist verify sender's blacklist
      # @option options [Hash] :contentAvailable for iOS devices, see docs for more details
      #
      def send_message(from_user_id, target_id, channel_name, object_name, content, *args)
        options = args.extract_options!
        values = args.first
        content_type = values.nil? ? :form_data : :json

        message_channel = MessageChannel.new(channel_name)
        params = { fromUserId: from_user_id, objectName: object_name, content: content.to_json }
        if message_channel.target_param_name
          params.merge!(message_channel.target_param_name => target_id)
        end
        if values
          if options[:pushContent].nil?
            raise RongCloud::MissingOptionError, "pushContent is required for template messages"
          end
          params.merge!(values: values)
        end

        params.merge!(options)
        request(message_channel.api_path, params, content_type)
      end

      def send_private_message(from_user_id, to_user_id, object_name, content, options = {})
        send_message(from_user_id, to_user_id, :private, object_name, content, options)
      end

      def send_private_template_message(from_user_id, to_user_id, object_name, content, values, options = {})
        send_message(from_user_id, to_user_id, :private_template, object_name, content, values, options)
      end

      def send_system_message(from_user_id, to_user_id, object_name, content, options = {})
        send_message(from_user_id, to_user_id, :system, object_name, content, options)
      end

      def send_system_template_message(from_user_id, to_user_id, object_name, content, values, options = {})
        send_message(from_user_id, to_user_id, :system_template, object_name, content, values, options)
      end

      def send_group_message(from_user_id, to_group_id, object_name, content, options = {})
        send_message(from_user_id, to_group_id, :group, object_name, content, options)
      end

      def send_discussion_message(from_user_id, to_discussion_id, object_name, content, options = {})
        send_message(from_user_id, to_discussion_id, :discussion, object_name, content, options)
      end

      def send_chatroom_message(from_user_id, to_chatroom_id, object_name, content, options = {})
        send_message(from_user_id, to_chatroom_id, :chatroom, object_name, content, options)
      end

      def send_chatroom_broadcast_message(from_user_id, object_name, content, options = {})
        send_message(from_user_id, nil, :chatroom_broadcast, object_name, content, options)
      end

      def send_broadcast_message(from_user_id, object_name, content, options = {})
        send_message(from_user_id, nil, :broadcast, object_name, content, options)
      end
    end
  end
end