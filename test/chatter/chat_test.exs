defmodule Chatter.ChatTest do
  use Chatter.DataCase, async: true

  describe "Chat.list_rooms/0" do
    test "returns empty list if no rooms" do
      assert Chatter.Chat.list_rooms() == []
    end

    test "returns list of rooms" do
      [r1, r2] = insert_pair(:chat_room)
      assert rooms = Chatter.Chat.list_rooms()
      assert length(rooms) == 2
      assert r1 in rooms
      assert r2 in rooms
    end
  end
end
