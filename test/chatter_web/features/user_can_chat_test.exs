defmodule ChatterWeb.Features.UserCanChatTest do
  use ChatterWeb.FeatureCase, async: true

  test "User can chat with others", %{metadata: metadata} do
    room = insert(:chat_room)

    user_1 =
      metadata
      |> new_user()
      |> visit(rooms_index())
      |> join_room(room.name)

    user_2 =
      metadata
      |> new_user()
      |> visit(rooms_index())
      |> join_room(room.name)

    user_1 =
      user_1
      |> add_message("hello friends, this is a message")
      |> assert_has(message("hello friends, this is a message"))

    _user_2 =
      user_2
      |> assert_has(message("hello friends, this is a message"))
      |> add_message("Hey user-1, welcome to #{room.name}")
      |> assert_has(message("Hey user-1, welcome to #{room.name}"))

    _user_1 =
      user_1
      |> assert_has(message("Hey user-1, welcome to #{room.name}"))
  end

  defp new_user(metadata) do
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    session
  end

  defp rooms_index(), do: Routes.chat_room_path(@endpoint, :index)

  defp join_room(session, room_name) do
    session |> click(Query.link(room_name))
  end

  defp add_message(session, message) do
    session
    |> fill_in(Query.text_field("message"), with: message)
    |> click(Query.button("Send"))
  end

  defp message(message) do
    Query.data("test", "message", text: message)
  end
end
