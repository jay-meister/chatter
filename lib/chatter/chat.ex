defmodule Chatter.Chat do
  alias Chatter.Repo

  alias Chatter.Chat.Room

  def get_chat_room(id) do
    Repo.get(Room, id)
  end

  def list_chat_rooms() do
    Repo.all(Room)
  end

  def new_chat_room() do
    %Room{}
    |> Room.changeset(%{})
  end

  def create_chat_room(params) do
    %Room{}
    |> Room.changeset(params)
    |> Repo.insert()
  end
end
