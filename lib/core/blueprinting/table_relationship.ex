defmodule Core.Blueprinting.TableRelationship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "table_relationships" do
    field :relationship_type, :string
    field :description, :string

    belongs_to :parent_table, Core.Blueprinting.Table
    belongs_to :child_table, Core.Blueprinting.Table

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(table_relationship, attrs) do
    table_relationship
    |> cast(attrs, [:relationship_type, :description, :parent_table_id, :child_table_id])
    |> validate_required([:relationship_type, :parent_table_id, :child_table_id])
    |> validate_relationship_type()
    |> foreign_key_constraint(:parent_table_id)
    |> foreign_key_constraint(:child_table_id)
  end

  defp validate_relationship_type(changeset) do
    valid_types = ["default", "per_tenant"]

    validate_inclusion(changeset, :relationship_type, valid_types)
  end
end
