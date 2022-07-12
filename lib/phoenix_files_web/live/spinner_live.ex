defmodule PhoenixFilesWeb.SpinnerLive do
  use PhoenixFilesWeb, :live_view

  import PhoenixFilesWeb.LiveHelpers

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :colors, get_colors())}
  end

  def render(assigns) do
    ~H"""
    <button class="px-4 py-2 font-semibold text-sm bg-cyan-500 text-white rounded-full shadow-sm ml-20" phx-click="create_palette">Create a new palette!</button>
    <!-- <button class="px-4 py-2 font-semibold text-sm bg-cyan-500 text-white rounded-full shadow-sm ml-20" phx-click={show_loader("#spinner_test")}>without server!</button> -->

    <div class="bg-white-400 h-80 w-80 relative z-0">
      <svg viewBox="3 -8 100 100">
        <defs>
          <g id="pod">
            <polygon stroke="#000000" stroke-width="0.5" points="5,-9 -5,-9 -10,0 -5,9 5,9 10,0" />
          </g>
        </defs>

        <g class="pod-wrap">
        <use xlink:href="#pod" fill={"##{@colors[0]}"} transform="translate(50, 5)"/>
        <use xlink:href="#pod" fill={"##{@colors[1]}"} transform="translate(35, 14)"/>
        <use xlink:href="#pod" fill={"##{@colors[2]}"} transform="translate(65, 14)"/>
        <use xlink:href="#pod" fill={"##{@colors[3]}"} transform="translate(20, 23)"/>
        <use xlink:href="#pod" fill={"##{@colors[4]}"} transform="translate(80, 23)"/>
        <use xlink:href="#pod" fill={"##{@colors[5]}"} transform="translate(50, 23)"/>
        <use xlink:href="#pod" fill={"##{@colors[6]}"} transform="translate(35, 32)"/>
        <use xlink:href="#pod" fill={"##{@colors[7]}"} transform="translate(65, 32)"/>
        <use xlink:href="#pod" fill="transparent" transform="translate(50, 41)"/>
        <use xlink:href="#pod" fill={"##{@colors[8]}"} transform="translate(20, 41)"/>
        <use xlink:href="#pod" fill={"##{@colors[9]}"} transform="translate(80, 41)"/>
        <use xlink:href="#pod" fill={"##{@colors[10]}"} transform="translate(35, 50)"/>
        <use xlink:href="#pod" fill={"##{@colors[11]}"} transform="translate(65, 50)"/>
        <use xlink:href="#pod" fill={"##{@colors[12]}"} transform="translate(50, 59)"/>
        <use xlink:href="#pod" fill={"##{@colors[13]}"} transform="translate(20, 59)"/>
        <use xlink:href="#pod" fill={"##{@colors[14]}"} transform="translate(80, 59)"/>
        <use xlink:href="#pod" fill={"##{@colors[15]}"} transform="translate(35, 68)"/>
        <use xlink:href="#pod" fill={"##{@colors[16]}"} transform="translate(65, 68)"/>
        <use xlink:href="#pod" fill={"##{@colors[17]}"} transform="translate(50, 77)"/>
        </g>
      </svg>
      <.loader id="spinner_test"/>

    </div>
    """
  end

  # def handle_params(_, _, socket) do
  #  socket = push_event(socket, "js-exec", %{to: "#spinner_test", attr: "data-show"})
  #  {:noreply, socket}
  # end

  # def handle_event("show_loader", _value, socket) do
  #  socket = push_event(socket, "js-exec", %{to: "#spinner_test", attr: "data-show"})
  #  {:noreply, socket}
  # end

  # def handle_event("hide_loader", _value, socket) do
  #  socket = push_event(socket, "js-exec", %{to: "#spinner_test", attr: "data-hide"})
  #  {:noreply, socket}
  # end

  def handle_event("create_palette", _value, socket) do
    send(self(), :run_request)
    socket = push_event(socket, "js-exec", %{to: "#spinner_test", attr: "data-show"})
    {:noreply, socket}
  end

  def handle_info(:run_request, socket) do
    socket =
      socket
      |> push_event("js-exec", %{to: "#spinner_test", attr: "data-hide"})
      |> assign(:colors, get_colors())

    {:noreply, socket}
  end

  defp get_colors() do
    url = "https://palett.es/API/v1/colors/18?#{to_string(:rand.uniform(20))}"

    response = HTTPoison.get!(url)

    response.body
    |> Poison.decode!()
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {color, idx}, acc -> Map.put_new(acc, idx, color) end)
  end
end
