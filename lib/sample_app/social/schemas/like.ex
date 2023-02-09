defmodule SampleApp.Social.Schemas.Like do
  use Ecto.Schema

  import Ecto.Changeset

  schema "likes" do
    field :created_at, :naive_datetime
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [:created_at])
    |> validate_required([:created_at])
  end
end
