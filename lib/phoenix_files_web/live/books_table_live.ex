defmodule PhoenixFilesWeb.BooksTableLive do
  use PhoenixFilesWeb, :live_view

  alias PhoenixFiles.MultiSelect.SelectOption

  def mount(_params, _session, socket) do


    {:ok, socket}
  end


  def render(assigns) do
    ~H"""

    <div>
      <.live_component id="multi" module={PhoenixFilesWeb.MultiSelectComponent} />
    </div>
    """
  end

end
