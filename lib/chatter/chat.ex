defmodule Chatter.Chat do
  alias Chatter.Repo

  def list_rooms() do
    Repo.all(Chatter.Chat.Room)
  end
end
