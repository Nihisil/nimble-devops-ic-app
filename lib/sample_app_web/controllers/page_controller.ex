# credo:disable-for-this-file CompassCredoPlugin.Check.DoSingleExpression
defmodule SampleAppWeb.PageController do
  use SampleAppWeb, :controller

  alias SampleApp.Social.Likes

  def index(conn, _params) do
    likes_count = Likes.get_number_of_likes()

    render(conn, "index.html", %{:likes_count => likes_count})
  end

  def create(conn, _params) do
    Likes.create_like()

    redirect(conn, to: Routes.page_path(conn, :index))
  end
end
