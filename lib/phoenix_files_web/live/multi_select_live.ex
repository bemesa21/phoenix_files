defmodule PhoenixFilesWeb.MultiSelectLive do
  use PhoenixFilesWeb, :live_view

  alias PhoenixFiles.MultiSelect
  alias PhoenixFiles.MultiSelect.SelectOption

  def render(assigns) do
    ~H"""
    <div class="border border-gray-200 dark:border-gray-700 w-96 h-10 ">
      <div class="w-96 flex" id="selected_options_container" phx-update="append" >
        <%= for option <- @selected_options do %>
          <div id={"option_#{option.data.name}"} class="bg-purple-500 shadow-lg rounded-lg mt-2 ml-1 text-white dark:bg-sky-500  w-16 text-center">
            <%= option.data.name %>
          </div>
        <% end %>
       </div>
      <div class="relative">
        <svg id="down" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 absolute right-0 top-2" viewBox="0 0 20 20" fill="currentColor" phx-click={JS.toggle() |> JS.toggle(to: "#up") |> JS.toggle(to: "#multiselect-form")}>
          <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
        </svg>
        <svg id="up" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5  absolute right-0 top-2 hidden" viewBox="0 0 20 20" fill="currentColor"  phx-click={JS.toggle() |> JS.toggle(to: "#down") |> JS.toggle(to: "#multiselect-form")}>
          <path fill-rule="evenodd" d="M14.707 12.707a1 1 0 01-1.414 0L10 9.414l-3.293 3.293a1 1 0 01-1.414-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 010 1.414z" clip-rule="evenodd" />
        </svg>
      </div>
    </div>
    <.form let={f} for={@changeset} class="w-96 hidden mt-4 p-4 shadow-2xl rounded-lg" id="multiselect-form">
      <%= inputs_for f, :values, fn value -> %>
        <div class="form-check">
          <label class="form-check-label inline-block text-gray-800">
            <%= checkbox value, :selected, phx_change: "checked", value: value.data.selected, class: "form-check-input appearance-none h-4 w-4 border border-gray-300 rounded-sm bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer" %>
            <span class="ml-2"><%= value.data.data.name %></span>
          </label>
        </div>
      <% end %>
    </.form>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_new(:changeset, &get_values/0)

    {:ok, socket, temporary_assigns: [selected_options: []]}
  end

  def handle_event("checked", %{"multi_select" => %{"values" => values}}, socket) do
    [{index, %{"selected" => selected?}}] = Map.to_list(values)

    index = String.to_integer(index)
    multi_options = Ecto.Changeset.get_field(socket.assigns.changeset, :values)

    socket =
      if selected? === "true" do
        new_message = Enum.at(multi_options, index)
        assign(socket, :selected_options, [new_message])
      else
        socket
      end

    old_value = Enum.at(multi_options, index)
    updated_options = List.replace_at(multi_options, index, %{old_value | selected: selected?})

    updated_changeset =
      %MultiSelect{}
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_embed(:values, updated_options)

    {:noreply, assign(socket, :changeset, updated_changeset) |> IO.inspect()}
  end

  defp get_values() do
    values = [
      %SelectOption{data: %{name: "Red"}},
      %SelectOption{data: %{name: "White"}}
    ]

    %MultiSelect{}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_embed(:values, values)
  end
end
