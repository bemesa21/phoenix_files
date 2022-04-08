defmodule PhoenixFiles.MultiSelect do
  use Ecto.Schema

  embedded_schema do
    embeds_many :values, PhoenixFiles.MultiSelect.SelectOption
  end

  defmodule SelectOption do
    use Ecto.Schema

    embedded_schema do
      field :selected, :boolean, default: false
      field :data, :map, null: false
    end
  end
end
