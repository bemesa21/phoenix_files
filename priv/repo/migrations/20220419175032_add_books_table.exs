defmodule PhoenixFiles.Repo.Migrations.AddBooksTable do
  use Ecto.Migration

  def up do
    create table("books") do
      add :title, :string, size: 40
      add :price, :integer
      add :cover, :string
      add :category, {:array, :string}
      add :description, :string
      timestamps()
    end
  end

  def down do
    drop table("books")
  end
end
