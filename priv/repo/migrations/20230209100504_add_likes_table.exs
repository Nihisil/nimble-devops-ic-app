defmodule SampleApp.Repo.Migrations.AddLikesTable do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :created_at, :naive_datetime, null: false
    end
  end
end
