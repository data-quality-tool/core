defmodule Core.Blueprinting.Datasource do
  use Ecto.Schema
  import Ecto.Changeset

  schema "datasources" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(datasource, attrs) do
    datasource
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
