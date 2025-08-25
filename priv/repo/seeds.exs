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
alias Core.Blueprinting.{Datasource, Table}

# Create datasources
datasources = [
  %{name: "jocker"},
  %{name: "ruby"},
  %{name: "penta"},
  %{name: "dwh"}
]

# Insert datasources and get their IDs
datasource_records = Enum.map(datasources, fn datasource ->
  Repo.insert!(Datasource.changeset(%Datasource{}, datasource))
end)

# Create tables for each datasource
table_names = ["users", "transactions", "games"]

Enum.each(datasource_records, fn datasource ->
  Enum.each(table_names, fn table_name ->
    Repo.insert!(Table.changeset(%Table{}, %{
      name: table_name,
      datasource_id: datasource.id
    }))
  end)
end)

IO.puts("Created #{length(datasource_records)} datasources with #{length(table_names)} tables each")
