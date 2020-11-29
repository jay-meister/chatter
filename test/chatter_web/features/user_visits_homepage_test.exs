defmodule ChatterWeb.UserVisitsHomepageTest do
  use ChatterWeb.FeatureCase, async: true

  describe "user visits rooms page" do
    defp paths_rooms_index(), do: Routes.chat_room_path(@endpoint, :index)
    defp page_header(text), do: Query.data("test", "title", text: text)
    defp data_tag(tag, text), do: Query.data("test", tag, text: text)
    defp no_rooms(), do: data_tag("no-rooms", "No chat rooms yet")

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
      |> assert_has(data_tag("room", room1.name))
      |> assert_has(data_tag("room", room2.name))
    end
  end
end
