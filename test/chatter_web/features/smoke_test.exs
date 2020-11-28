for n <- 1..20 do
  defmodule "ChatterWeb.SmokeTest#{n}" |> String.to_atom() do
    IO.inspect("defmodule: #{n}")
    use ChatterWeb.FeatureCase, async: true

    test "SMOKE FEATURE", %{session: session} do
      IO.inspect("test: #{unquote(n)}")

      Process.sleep(3000)

      session
      |> visit("/")
      |> assert_has(Query.css(".title", text: "Welcome"))
    end
  end
end
