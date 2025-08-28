defmodule Core.Blueprinting.Datasource do
  use Ecto.Schema
  import Ecto.Changeset

  schema "datasources" do
    field :name, :string
    field :multitenant, :boolean, default: false
    field :tenants, {:array, :string}, default: []

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(datasource, attrs) do
    datasource
    |> cast(attrs, [:name, :multitenant, :tenants])
    |> validate_required([:name])
  end
end
