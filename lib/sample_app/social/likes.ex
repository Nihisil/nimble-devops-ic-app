defmodule SampleApp.Social.Likes do
  import Ecto.Query, warn: false

  alias SampleApp.Social.Schemas.Like

  def create_like do
    attrs = %{:created_at => NaiveDateTime.utc_now()}

    %Like{}
    |> Like.changeset(attrs)
    |> SampleApp.Repo.insert()
  end

  def get_number_of_likes, do: SampleApp.Repo.aggregate(Like, :count, :id)
end
