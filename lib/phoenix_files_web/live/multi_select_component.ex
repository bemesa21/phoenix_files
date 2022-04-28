defmodule PhoenixFilesWeb.MultiSelectComponent do
  use PhoenixFilesWeb, :live_component

  alias PhoenixFiles.MultiSelect

  def render(assigns) do
    ~H"""
    <div class="flex justify-center">
      <div class="border border-gray-200 dark:border-gray-700 w-96 h-12 pb-2 m-2 w-96 flex relative" id="selected_options_container">
        <%= for option <- @selected_options do %>
          <div id={"option_#{option.label}"} class="bg-purple-500 shadow-lg rounded-lg mt-2 ml-1 text-white dark:bg-sky-500 inline-block pl-2 pr-2 text-center">
            <%= option.label %>
          </div>
        <% end %>
        <div class="absolute right-0">
          <svg id="down" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 absolute right-0 top-3" viewBox="0 0 20 20" fill="currentColor" phx-click={JS.toggle() |> JS.toggle(to: "#up") |> JS.toggle(to: "#multiselect-form")}>
            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
          </svg>
          <svg id="up" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5  absolute right-0 top-3 hidden" viewBox="0 0 20 20" fill="currentColor"  phx-click={JS.toggle() |> JS.toggle(to: "#down") |> JS.toggle(to: "#multiselect-form")}>
            <path fill-rule="evenodd" d="M14.707 12.707a1 1 0 01-1.414 0L10 9.414l-3.293 3.293a1 1 0 01-1.414-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 010 1.414z" clip-rule="evenodd" />
          </svg>
         </div>
      </div>
      <.form let={f} for={@changeset} phx-target={@myself} class="hidden w-96 mt-4 p-4 ml-2 mt-16 absolute z-10 bg-stone-50 shadow-2xl rounded-lg" id="multiselect-form">
        <%= inputs_for f, :options, fn value -> %>
          <div class="form-check">
            <label class="form-check-label inline-block text-gray-800">
              <%= checkbox value, :selected, phx_change: "checked", value: value.data.selected, class: "form-check-input appearance-none h-4 w-4 border border-gray-300 rounded-sm bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer" %>
              <span class="ml-2"><%= value.data.label %></span>
            </label>
          </div>
        <% end %>
      </.form>
    </div>
    """
  end

  def update(%{options: options}, socket) do
    changeset = build_changeset(options)

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:selected_options, filter_selected_options(options))

    {:ok, socket}
  end

  def handle_event("checked", %{"multi_select" => %{"options" => values}}, socket) do
    [{index, %{"selected" => selected?}}] = Map.to_list(values)
    index = String.to_integer(index)
    multi_options = Ecto.Changeset.get_field(socket.assigns.changeset, :options)
    current_option = Enum.at(multi_options, index)

    updated_options =
      List.replace_at(multi_options, index, %{current_option | selected: selected?})

    send(self(), {:updated_options, updated_options})
    {:noreply, socket}
  end

  defp build_changeset(options) do
    %MultiSelect{}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_embed(:options, options)
  end

  defp filter_selected_options(options) do
    Enum.filter(options, fn opt -> opt.selected == true or opt.selected == "true" end)
  end
end
