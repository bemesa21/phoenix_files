defmodule PhoenixFilesWeb.BooksTableLive do
  use PhoenixFilesWeb, :live_view

  alias PhoenixFiles.MultiSelect.SelectOption

  def mount(_params, _session, socket) do

    options =
    [
      %{id: 1, label: "Red", selected: false},
      %{id: 2, label: "Blue", selected: true},
      %{id: 3, label: "Pink", selected: false}
    ] #hardcoded values
    |> build_options()

    {:ok, assign(socket, :options, options)}
  end


  def render(assigns) do
    ~H"""
    <div>
      <.live_component id="multi" module={PhoenixFilesWeb.MultiSelectComponent} options={@options} />
    </div>
    """
  end

  def handle_info({:updated_options, options}, socket) do
    # update the list of options in the multiselect component
    {:noreply, assign(socket, :options, options)}
  end

  defp build_options(options) do
    Enum.reduce(options, [], fn data, acc ->
      [%SelectOption{id: data.id, label: data.label, selected: data.selected} | acc]
    end)
  end
end
