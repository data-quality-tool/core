defmodule Core.Blueprinting.CheckBlueprint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "check_blueprints" do
    field :name, :string
    field :table_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(check_blueprint, attrs) do
    check_blueprint
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
