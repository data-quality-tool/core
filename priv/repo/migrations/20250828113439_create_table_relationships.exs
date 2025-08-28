defmodule Core.Repo.Migrations.CreateTableRelationships do
  use Ecto.Migration

  def change do
    create table(:table_relationships) do
      add :parent_table_id, references(:tables, on_delete: :delete_all), null: false
      add :child_table_id, references(:tables, on_delete: :delete_all), null: false
      add :relationship_type, :string, null: false
      add :description, :text

      timestamps(type: :utc_datetime)
    end

    create index(:table_relationships, [:parent_table_id])
    create index(:table_relationships, [:child_table_id])

    create unique_index(:table_relationships, [:parent_table_id, :child_table_id],
             name: :table_relationships_unique_pair
           )
  end
end
