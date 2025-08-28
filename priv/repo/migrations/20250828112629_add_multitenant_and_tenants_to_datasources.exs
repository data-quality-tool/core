defmodule Core.Repo.Migrations.AddMultitenantAndTenantsToDatasources do
  use Ecto.Migration

  def change do
    alter table(:datasources) do
      add :multitenant, :boolean, default: false, null: false
      add :tenants, {:array, :string}, default: [], null: false
    end
  end
end
