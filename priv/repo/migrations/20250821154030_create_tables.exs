defmodule Core.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:tables) do
      add :name, :string
      add :datasource_id, references(:datasources, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:tables, [:datasource_id])
  end
end
