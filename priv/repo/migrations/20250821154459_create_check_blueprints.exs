defmodule Core.Repo.Migrations.CreateCheckBlueprints do
  use Ecto.Migration

  def change do
    create table(:check_blueprints) do
      add :name, :string
      add :table_id, references(:tables, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:check_blueprints, [:table_id])
  end
end
