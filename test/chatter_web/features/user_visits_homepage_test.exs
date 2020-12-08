defmodule ChatterWeb.UserVisitsHomepageTest do
  use ChatterWeb.FeatureCase, async: true

  describe "user visits rooms page" do
    test "and is told there are no rooms", %{session: session} do
      session
      |> visit(paths_rooms_index())
      |> assert_has(page_header("Welcome to Chatter!"))
      |> assert_has(no_rooms())
    end

    test "to see list of rooms", %{session: session} do
      [room1, room2] = insert_pair(:chat_room)

      session
      |> visit(paths_rooms_index())
      |> assert_has(page_header("Welcome to Chatter!"))
      |> assert_has(room_with_name(room1.name))
      |> assert_has(room_with_name(room2.name))
    end
  end

  describe "user creates chat room" do
    test "success", %{session: session} do
      session
      |> visit(paths_rooms_index())
      |> click(new_chat_link())
      |> new_chat_room(name: "my room")
      |> assert_has(room_title("my room"))
    end
  end

  defp paths_rooms_index(), do: Routes.chat_room_path(@endpoint, :index)
  defp tag(tag, text), do: Query.data("test", tag, text: text)

  defp page_header(text), do: Query.data("test", "title", text: text)
  defp room_with_name(text), do: Query.data("test", "room-name", text: text)

  defp no_rooms(), do: tag("no-rooms", "No chat rooms yet")

  defp new_chat_link(), do: Query.link("New chat room")

  defp new_chat_room(session, name: name) do
    session
    |> fill_in(Query.text_field("Name"), with: name)
    |> click(Query.button("Submit"))
  end

  defp room_title(text), do: Query.data("test", "room-title", text: text)
end
