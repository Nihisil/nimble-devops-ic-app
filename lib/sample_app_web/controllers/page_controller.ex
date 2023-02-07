# credo:disable-for-this-file CompassCredoPlugin.Check.DoSingleExpression
defmodule SampleAppWeb.PageController do
  use SampleAppWeb, :controller

  def index(conn, _params) do
    cache_key = "test"
    SampleApp.RedisCache.put(cache_key, "some-value")
    value = SampleApp.RedisCache.get(cache_key)

    render(conn, "index.html", %{:value => value})
  end
end
