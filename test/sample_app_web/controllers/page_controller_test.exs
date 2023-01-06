defmodule SampleAppWeb.PageControllerTest do
  use SampleAppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Hi there!"
  end
end
