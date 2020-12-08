defmodule Chatter.ChatTest do
  use Chatter.DataCase, async: true

  alias Chatter.Chat

  describe "Chat.list_chat_rooms/0" do
    test "returns empty list if no rooms" do
      assert Chat.list_chat_rooms() == []
    end

    test "returns list of rooms" do
      [r1, r2] = insert_pair(:chat_room)
      assert rooms = Chat.list_chat_rooms()
      assert length(rooms) == 2
      assert r1 in rooms
      assert r2 in rooms
    end
  end

  describe "Chat.new_chat_room/0" do
    test "returns changeset" do
      assert %Ecto.Changeset{} = Chat.new_chat_room()
    end
  end

  describe "Chat.create_chat_room/1" do
    test "creates chat room" do
      params = string_params_for(:chat_room)

      {:ok, room} = Chat.create_chat_room(params)

      assert %Chat.Room{} = room
      assert room.name == params["name"]
    end

    test "returns error if invalid params" do
      insert(:chat_room, name: "my room")
      params = string_params_for(:chat_room, name: "my room")

      assert {:error, changeset} = Chat.create_chat_room(params)
      assert changeset.valid? == false
      assert "has already been taken" in errors_on(changeset).name
    end
  end

  describe "Chat.get_chat_room/1" do
    test "returns nil when room not exists" do
      assert Chat.get_chat_room(1) == nil
    end

    test "returns room when room exists" do
      room = insert(:chat_room)
      room_found = Chat.get_chat_room(room.id)
      assert room == room_found
    end
  end
end
