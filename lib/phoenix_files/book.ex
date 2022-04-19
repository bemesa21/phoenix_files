defmodule PhoenixFiles.Book do
  use Ecto.Schema
  alias PhoenixFiles.Repo

  schema "books" do
    field :title, :string
    field :price, :integer
    field :category, {:array, :string}
    field :cover, :string
    field :description, :string
    timestamps()

  end

  def insert_book(params) do
    Ecto.Changeset.change(%__MODULE__{}, params)
    |> Repo.insert!
  end

  def list_books() do
    Repo.all(__MODULE__)
  end
end
