defmodule SampleAppWeb.HealthPlug do
  @behaviour Plug

  import Plug.Conn

  alias Ecto.Adapters.SQL
  alias SampleApp.Repo

  require Logger

  @liveness_path ["liveness"]
  @readiness_path ["readiness"]

  @impl true
  def init(opts), do: opts

  @impl true
  def call(%{path_info: @liveness_path} = conn, _opts) do
    conn
    |> resp(:ok, "alive")
    |> halt()
  end

  @impl true
  def call(%{path_info: @readiness_path} = conn, _opts) do
    case readiness_check() do
      :ok ->
        conn
        |> resp(:ok, "ready")
        |> halt()

      :error ->
        conn
        |> resp(:internal_server_error, "")
        |> halt()
    end
  end

  @impl true
  def call(conn, _opts) do
    conn
    |> resp(:not_found, "")
    |> halt()
  end

  defp readiness_check do
    sql_ready =
      case SQL.query(Repo, "SELECT 1") do
        {:ok, _result} ->
          true

        {:error, exception} ->
          Logger.error(inspect(exception))

          false
      end

    redis_ready =
      try do
        SampleApp.RedisCache.get("test")

        true
      rescue
        exception ->
          Logger.error(inspect(exception))

          false
      end

    case sql_ready && redis_ready do
      true -> :ok
      false -> :error
    end
  end
end
