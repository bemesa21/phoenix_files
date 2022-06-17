defmodule PhoenixFilesWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  def loader(assigns) do
    ~H"""
    <div class="hidden h-full bg-slate-100" id={@id} data-show={show_loader(@id)} data-hide={hide_loader(@id)}>
      <div class="flex justify-center items-center h-full">
        <div class="flower-spinner">
          <div class="dots-container">
            <div class="bigger-dot">
              <div class="smaller-dot"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def show_loader(js \\ %JS{}, id) do
    JS.show(js, to: "##{id}", transition: {"ease-out duration-300", "opacity-0", "opacity-100"})
  end

  def hide_loader(js \\ %JS{}, id) do
    JS.hide(js, to: "##{id}", transition: {"ease-in duration-300", "opacity-100", "opacity-0"})
  end
end
