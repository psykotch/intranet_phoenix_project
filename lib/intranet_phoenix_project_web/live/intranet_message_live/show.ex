defmodule IntranetPhoenixProjectWeb.IntranetMessageLive.Show do
  use IntranetPhoenixProjectWeb, :live_view

  alias IntranetPhoenixProject.Chats

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:intranet_message, Chats.get_intranet_message!(id))}
  end

  defp page_title(:show), do: "Show Intranet message"
  defp page_title(:edit), do: "Edit Intranet message"
end
