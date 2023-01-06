defmodule SampleAppWeb.ReadinessRequestTest do
  use SampleAppWeb.ConnCase, async: true

  test "returns 200", %{conn: conn} do
    conn =
      get(
        conn,
        "#{Application.get_env(:sample_app, SampleAppWeb.Endpoint)[:health_path]}/readiness"
      )

    assert response(conn, :ok) =~ "ready"
  end
end
