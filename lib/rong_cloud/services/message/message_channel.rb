module RongCloud
  module Services
    module Message
      class MessageChannel
        CHANNEL_TO_REQUEST_DETAILS_MAP = {
          'private': { target_param_name: "toUserId", api_path: "/message/private/publish" },
          system: { target_param_name: "toUserId", api_path: "/message/system/publish" },
          group: { target_param_name: 'toGroupId', api_path: "/message/group/publish" },
          discussion: { target_param_name: "toDiscussionId", api_path: "/message/discussion/publish" },
          chatroom: { target_param_name: "toChatroomId", api_path: "/message/chatroom/publish" },
          broadcast: { api_path: "/message/broadcast" }
        }.freeze
        VALID_CHANNEL_NAMES = CHANNEL_TO_REQUEST_DETAILS_MAP.keys.map(&:to_s).freeze

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