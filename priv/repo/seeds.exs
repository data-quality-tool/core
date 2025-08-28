# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Core.Repo.insert!(%Core.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Core.Repo
alias Core.Blueprinting.{Datasource, Table, TableRelationship}

# Create datasources
datasources = [
  %{name: "PG.A", multitenant: true, tenants: ["jocker", "ruby", "penta"]},
  %{name: "dwh", multitenant: false, tenants: []}
]

# Insert datasources and get their IDs
datasource_records =
  Enum.map(datasources, fn datasource ->
    Repo.insert!(Datasource.changeset(%Datasource{}, datasource))
  end)

# Create tables for each datasource
table_names = ["users", "transactions", "games"]

all_table_records =
  Enum.reduce(datasource_records, [], fn datasource, acc ->
    datasource_tables =
      Enum.map(table_names, fn table_name ->
        table =
          Repo.insert!(
            Table.changeset(%Table{}, %{
              name: table_name,
              datasource_id: datasource.id
            })
          )

        table
      end)

    acc ++ datasource_tables
  end)

# Create relationships between tables with the same names from different datasources
# PG.A tables as parents, dwh tables as children
pg_a_datasource = Enum.find(datasource_records, fn ds -> ds.name == "PG.A" end)
dwh_datasource = Enum.find(datasource_records, fn ds -> ds.name == "dwh" end)

pg_a_tables =
  Enum.filter(all_table_records, fn table -> table.datasource_id == pg_a_datasource.id end)

dwh_tables =
  Enum.filter(all_table_records, fn table -> table.datasource_id == dwh_datasource.id end)

# Create relationships for each table type
Enum.each(table_names, fn table_name ->
  pg_a_table = Enum.find(pg_a_tables, fn table -> table.name == table_name end)
  dwh_table = Enum.find(dwh_tables, fn table -> table.name == table_name end)

  Repo.insert!(
    TableRelationship.changeset(%TableRelationship{}, %{
      parent_table_id: pg_a_table.id,
      child_table_id: dwh_table.id,
      relationship_type: "per_tenant",
      description: "PG.A #{table_name} table is parent of DWH #{table_name} table"
    })
  )
end)

IO.puts(
  "Created #{length(datasource_records)} datasources with #{length(table_names)} tables each and relationships"
)
