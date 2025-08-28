defmodule Core.Blueprinting.Table do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "tables" do
    field :name, :string
    field :datasource_id, :id

    # Many-to-many relationships
    has_many :parent_relationships, Core.Blueprinting.TableRelationship,
      foreign_key: :parent_table_id

    has_many :child_relationships, Core.Blueprinting.TableRelationship,
      foreign_key: :child_table_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(table, attrs) do
    table
    |> cast(attrs, [:name, :datasource_id])
    |> validate_required([:name, :datasource_id])
  end

  @doc """
  Get all related tables for a given table
  """
  def related_tables(table) do
    import Ecto.Query

    # Get child tables (tables that this table is parent of)
    child_tables =
      from t in Core.Blueprinting.Table,
        join: tr in Core.Blueprinting.TableRelationship,
        on: tr.child_table_id == t.id,
        where: tr.parent_table_id == ^table.id,
        select: %{table: t, relationship: tr}

    # Get parent tables (tables that are parents of this table)
    parent_tables =
      from t in Core.Blueprinting.Table,
        join: tr in Core.Blueprinting.TableRelationship,
        on: tr.parent_table_id == t.id,
        where: tr.child_table_id == ^table.id,
        select: %{table: t, relationship: tr}

    Core.Repo.all(child_tables) ++ Core.Repo.all(parent_tables)
  end
end
