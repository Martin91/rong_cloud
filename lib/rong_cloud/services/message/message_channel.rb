module RongCloud
  module Services
    module Message
      # 消息发送渠道，区分私信、系统消息、群组消息、讨论组消息、聊天室消息以及广播消息
      class MessageChannel
        # 各消息渠道各自对应请求路径以及特殊参数名
        #
        CHANNEL_TO_REQUEST_DETAILS_MAP = {
          'private': { target_param_name: "toUserId", api_path: "/message/private/publish" },
          system: { target_param_name: "toUserId", api_path: "/message/system/publish" },
          group: { target_param_name: 'toGroupId', api_path: "/message/group/publish" },
          discussion: { target_param_name: "toDiscussionId", api_path: "/message/discussion/publish" },
          chatroom: { target_param_name: "toChatroomId", api_path: "/message/chatroom/publish" },
          broadcast: { api_path: "/message/broadcast" }
        }.freeze
        # 支持的消息渠道的列表
        #
        VALID_CHANNEL_NAMES = CHANNEL_TO_REQUEST_DETAILS_MAP.keys.map(&:to_s).freeze

        # 实例化消息渠道对象
        #
        # @param channel_name [String] 渠道名称
        # @return [RongCloud::Services::Message::MessageChannel] 消息渠道实例
        # @raise [RongCloud::UnsupportedMessageChannelName] 消息渠道不支持
        #
        def initialize(channel_name)
          if VALID_CHANNEL_NAMES.include?(channel_name.to_s)
            @channel_name = channel_name.to_s.to_sym
          else
            raise UnsupportedMessageChannelName,
              "support only channels: #{VALID_CHANNEL_NAMES}"
          end
        end

        def target_param_name
          CHANNEL_TO_REQUEST_DETAILS_MAP[@channel_name][:target_param_name]
        end

        def api_path
          CHANNEL_TO_REQUEST_DETAILS_MAP[@channel_name][:api_path]
        end
      end
    end
  end
end