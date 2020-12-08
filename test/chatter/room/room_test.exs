defmodule Chatter.Chat.RoomTest do
  use Chatter.DataCase, async: true

  alias Chatter.Chat.Room

  describe "Room.changeset/2" do
    test "initially returns changeset for form" do
      assert %Ecto.Changeset{} = Room.changeset(%Room{}, %{})
    end

    test "name is required" do
      changeset = Room.changeset(%Room{}, %{"name" => ""})

      assert %Ecto.Changeset{valid?: false} = changeset
      assert "can't be blank" in errors_on(changeset).name
    end

    test "name is unique" do
      insert(:chat_room, name: "my room")
      params = params_for(:chat_room, name: "my room")

      changeset = %{valid?: true} = Room.changeset(%Room{}, params)

      assert {:error, changeset} = Repo.insert(changeset)
      assert "has already been taken" in errors_on(changeset).name
    end
  end
end
