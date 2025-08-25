defmodule Core.Repo.Migrations.CreateDatasources do
  use Ecto.Migration

  def change do
    create table(:datasources) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
