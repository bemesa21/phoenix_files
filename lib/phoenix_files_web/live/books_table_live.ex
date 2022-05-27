defmodule PhoenixFilesWeb.BooksTableLive do
  use PhoenixFilesWeb, :live_view

  alias PhoenixFiles.MultiSelect
  alias PhoenixFiles.MultiSelect.SelectOption
  alias PhoenixFiles.Book

  def mount(_params, _session, socket) do
    categories =
      [
        %{id: 1, label: "Fantasy", selected: false},
        %{id: 2, label: "Horror", selected: true},
        %{id: 3, label: "Literary Fiction", selected: false}
      ]
      # hardcoded values
      |> build_options()


    {:ok, assign_multi_select_options(socket, categories)}
  end

  def render(assigns) do
    ~H"""
    <div class="relative">
      <.form let={f} for={@changeset}  id="multiselect-form" phx-change="validate">
        <.live_component
          id="multi"
          module={PhoenixFilesWeb.MultiSelectComponent}
          options={@categories}
          form={f}
          selected={fn opts -> send(self(), {:updated_options, opts}) end}
        />
      </.form>
    </div>
    <div class="grid grid-cols-5">
      <%= for book <- @books do %>
        <div class="max-w-sm rounded overflow-hidden shadow-lg m-5">
          <img class="w-full h-96 object-contain" src={book.cover}>
          <div class="px-6 py-4">
            <div class="font-bold text-xl mb-2"><%= book.title %></div>
              <p class="text-gray-700 text-base">
                <%= book.description %>
              </p>
          </div>
          <div class="px-6 pt-4 pb-2">
            <%= for category <- book.category do %>
              <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2">#<%= category %></span>
            <% end %>
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  def handle_info({:updated_options, options}, socket) do
    # update the list of books, the selected categories and the changeset in the form
    {:noreply, assign_multi_select_options(socket, options)}
  end

  def handle_event("validate", %{"multi_select" => multi_component}, socket) do
    options = build_options(multi_component["options"])

    {:noreply, assign_multi_select_options(socket, options)}
  end

  defp assign_multi_select_options(socket, categories) do
    socket
    |> assign(:changeset, build_changeset(categories))
    |> assign(:books, filter_books(categories))
    |> assign(:categories, categories)
  end

  defp build_options(options) do
    Enum.map(options, fn
      {_idx, data} -> %SelectOption{id: data["id"], label: data["label"], selected: data["selected"]}
      data -> %SelectOption{id: data.id, label: data.label, selected: data.selected}
    end)
  end

  defp build_changeset(options) do
    %MultiSelect{}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_embed(:options, options)
  end

  defp filter_books(options) do
    selected_options =
      Enum.flat_map(options, fn option ->
        if option.selected in [true, "true"] do
          [option.label]
        else
          []
        end
    end)

    if selected_options == [] do
      Book.list_books()
    else
      Book.get_books_by_category(selected_options)
    end
  end
end
