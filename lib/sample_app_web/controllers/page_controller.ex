# credo:disable-for-this-file CompassCredoPlugin.Check.DoSingleExpression
defmodule SampleAppWeb.PageController do
  use SampleAppWeb, :controller

  alias SampleApp.Social.Likes

  @cache_likes_key "likes_count"

  def index(conn, _params) do
    {likes_count, from_cache} =
      case SampleApp.RedisCache.get(@cache_likes_key) do
        nil ->
          likes_count = Likes.get_number_of_likes()
          SampleApp.RedisCache.put(@cache_likes_key, likes_count)

          {likes_count, false}

        likes_count ->
          {likes_count, true}
      end

    render(conn, "index.html", %{:likes_count => likes_count, :from_cache => from_cache})
  end

  def create(conn, _params) do
    Likes.create_like()
    SampleApp.RedisCache.delete(@cache_likes_key)

    redirect(conn, to: Routes.page_path(conn, :index))
  end
end
