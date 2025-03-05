defmodule IntranetPhoenixProjectWeb.IntranetMessageLive.Index do
  use IntranetPhoenixProjectWeb, :live_view

  alias IntranetPhoenixProject.Chats
  alias IntranetPhoenixProject.Chats.IntranetMessage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :intranet_messages, Chats.list_intranet_messages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Intranet message")
    |> assign(:intranet_message, Chats.get_intranet_message!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Intranet message")
    |> assign(:intranet_message, %IntranetMessage{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Intranet messages")
    |> assign(:intranet_message, nil)
  end

  @impl true
  def handle_info({IntranetPhoenixProjectWeb.IntranetMessageLive.FormComponent, {:saved, intranet_message}}, socket) do
    {:noreply, stream_insert(socket, :intranet_messages, intranet_message)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    intranet_message = Chats.get_intranet_message!(id)
    {:ok, _} = Chats.delete_intranet_message(intranet_message)

    {:noreply, stream_delete(socket, :intranet_messages, intranet_message)}
  end
end
