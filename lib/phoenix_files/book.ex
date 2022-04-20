defmodule PhoenixFiles.Book do
  use Ecto.Schema
  import Ecto.Query

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
    |> Repo.insert!()
  end

  def list_books() do
    Repo.all(__MODULE__)
  end

  def get_books_by_category(categories) do
    Enum.reduce(categories, [], fn category, acc ->
      Repo.all(
        from(
          b in __MODULE__,
          where: ^category in b.category
        )
      ) ++ acc
    end)
    |> Enum.uniq()
  end
end
