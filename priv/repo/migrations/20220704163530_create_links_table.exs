defmodule ShorterApi.Repo.Migrations.CreateLinksTable do
  use Ecto.Migration

  def change do
    create table(:links, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :url, :string
      add :hash, :string
      add :clicks, :integer
      add :enabled, :boolean
      add :users_id, references(:users, type: :uuid, on_delete: :delete_all), null: false
      timestamps()
    end

    create unique_index(:links, [:hash], name: :link_hash_index)
  end
end
