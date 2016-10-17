module RongCloud
  module Services
    module ChatroomTest
      def test_create_chatroom
        chatrooms = { 10001 => "name1", 10002 => "name2" }
        response = @service.create_chatroom(chatrooms)
        assert_equal 200, response["code"]
      end
    end
  end
end