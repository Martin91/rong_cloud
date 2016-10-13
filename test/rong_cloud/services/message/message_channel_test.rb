require 'rong_cloud/services/message/message_channel'

module RongCloud
  module Services
    module Message
      class MessageChannelTest < Minitest::Test
        def test_initialize_with_supported_channel_name
          channel = RongCloud::Services::Message::MessageChannel.new(:private)
          assert channel
        end

        def test_initialize_with_unsupported_channel_name
          error = assert_raises RongCloud::UnsupportedMessageChannelName do
            RongCloud::Services::Message::MessageChannel.new(:nothing)
          end
          expected_error = "support only channels: [\"private\", \"private_template\", \"system\", \"system_template\", \"group\", \"discussion\", \"chatroom\", \"broadcast\"]"
          assert_equal expected_error, error.message
        end

        def test_target_param_name_for_private
          channel = RongCloud::Services::Message::MessageChannel.new(:private)
          assert_equal "toUserId", channel.target_param_name
        end

        def test_target_param_name_for_private_template
          channel = RongCloud::Services::Message::MessageChannel.new(:private_template)
          assert_equal "toUserId", channel.target_param_name
        end

        def test_target_param_name_for_system
          channel = RongCloud::Services::Message::MessageChannel.new(:system)
          assert_equal "toUserId", channel.target_param_name
        end

        def test_target_param_name_for_system_template
          channel = RongCloud::Services::Message::MessageChannel.new(:system_template)
          assert_equal "toUserId", channel.target_param_name
        end

        def test_target_param_name_for_group
          channel = RongCloud::Services::Message::MessageChannel.new(:group)
          assert_equal "toGroupId", channel.target_param_name
        end

        def test_target_param_name_for_discussion
          channel = RongCloud::Services::Message::MessageChannel.new(:discussion)
          assert_equal "toDiscussionId", channel.target_param_name
        end

        def test_target_param_name_for_chatroom
          channel = RongCloud::Services::Message::MessageChannel.new(:chatroom)
          assert_equal "toChatroomId", channel.target_param_name
        end

        def test_target_param_name_for_broadcast
          channel = RongCloud::Services::Message::MessageChannel.new(:broadcast)
          assert_nil channel.target_param_name
        end

        def test_api_path_for_private
          channel = RongCloud::Services::Message::MessageChannel.new(:private)
          assert_equal "/message/private/publish", channel.api_path
        end

        def test_api_path_for_private_template
          channel = RongCloud::Services::Message::MessageChannel.new(:private_template)
          assert_equal "/message/private/publish_template", channel.api_path
        end

        def test_api_path_for_system
          channel = RongCloud::Services::Message::MessageChannel.new(:system)
          assert_equal "/message/system/publish", channel.api_path
        end

        def test_api_path_for_system_template
          channel = RongCloud::Services::Message::MessageChannel.new(:system_template)
          assert_equal "/message/system/publish_template", channel.api_path
        end

        def test_api_path_for_group
          channel = RongCloud::Services::Message::MessageChannel.new(:group)
          assert_equal "/message/group/publish", channel.api_path
        end

        def test_api_path_for_discussion
          channel = RongCloud::Services::Message::MessageChannel.new(:discussion)
          assert_equal "/message/discussion/publish", channel.api_path
        end

        def test_api_path_for_chatroom
          channel = RongCloud::Services::Message::MessageChannel.new(:chatroom)
          assert_equal "/message/chatroom/publish", channel.api_path
        end

        def test_api_path_for_broadcast
          channel = RongCloud::Services::Message::MessageChannel.new(:broadcast)
          assert_equal "/message/broadcast", channel.api_path
        end
      end
    end
  end
end