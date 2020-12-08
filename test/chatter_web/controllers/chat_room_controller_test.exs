defmodule Chatter.ChatRoomControllerTest do
  use ChatterWeb.ConnCase, async: true

  describe "create chat room" do
    test "errors are returned to user", %{conn: conn} do
      params = string_params_for(:chat_room, name: "")

      response =
        conn
        |> post(Routes.chat_room_path(@endpoint, :create), %{"room" => params})
        |> html_response(200)

      assert response =~ "There was an error"
      assert response =~ "can&#39;t be blank"
    end
  end
end
