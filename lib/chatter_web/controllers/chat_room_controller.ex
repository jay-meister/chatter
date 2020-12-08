defmodule ChatterWeb.ChatRoomController do
  use ChatterWeb, :controller

  alias Chatter.Chat

  def index(conn, _params) do
    chat_rooms = Chat.list_chat_rooms()

    conn
    |> render("index.html", chat_rooms: chat_rooms)
  end

  def new(conn, _params) do
    changeset = Chat.new_chat_room()

    conn
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"room" => params}) do
    case Chat.create_chat_room(params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room #{room.name} created")
        |> redirect(to: Routes.chat_room_path(conn, :show, room))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "There was an error")
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chat_room = Chat.get_chat_room(id)

    messages = []

    conn
    |> render("show.html", chat_room: chat_room, messages: messages)
  end
end
