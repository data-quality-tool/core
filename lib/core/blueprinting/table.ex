defmodule Core.Blueprinting.Table do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tables" do
    field :name, :string
    field :datasource_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(table, attrs) do
    table
    |> cast(attrs, [:name, :datasource_id])
    |> validate_required([:name, :datasource_id])
  end
end
