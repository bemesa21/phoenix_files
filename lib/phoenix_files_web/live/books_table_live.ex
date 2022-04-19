defmodule PhoenixFilesWeb.BooksTableLive do
  use PhoenixFilesWeb, :live_view

  alias PhoenixFiles.MultiSelect.SelectOption
  alias PhoenixFiles.Book


  def mount(_params, _session, socket) do

    options =
    [
      %{id: 1, label: "Fantasy", selected: false},
      %{id: 2, label: "Horror", selected: true},
      %{id: 3, label: "Literary Fiction", selected: false}
    ] #hardcoded values
    |> build_options()


    books = Book.list_books()

    socket =
    socket
    |> assign(:options, options)
    |> assign(:books, books)
    {:ok, socket}
  end


  def render(assigns) do
    ~H"""
    <div>
      <.live_component id="multi" module={PhoenixFilesWeb.MultiSelectComponent} options={@options} />
    </div>
    <div class="grid grid-cols-5">
      <%= for book <- @books do %>
      <div class="max-w-sm rounded overflow-hidden shadow-lg m-5">
        <img class="w-full h-26" src={book.cover } alt="Sunset in the mountains">
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
    # update the list of options in the multiselect component
    {:noreply, assign(socket, :options, options)}
  end

  defp build_options(options) do
    Enum.reduce(options, [], fn data, acc ->
      [%SelectOption{id: data.id, label: data.label, selected: data.selected} | acc]
    end)
  end
end
