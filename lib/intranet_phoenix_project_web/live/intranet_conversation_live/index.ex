defmodule IntranetPhoenixProjectWeb.IntranetConversationLive.Index do
  use IntranetPhoenixProjectWeb, :live_view

  alias IntranetPhoenixProject.Chats
  alias IntranetPhoenixProject.Chats.IntranetConversation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket |> assign(:salutation, "coucou") |> assign(:message, "c'est moi"), :intranet_conversations, Chats.list_intranet_conversations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Intranet conversation")
    |> assign(:intranet_conversation, Chats.get_intranet_conversation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Intranet conversation")
    |> assign(:intranet_conversation, %IntranetConversation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Intranet conversations")
    |> assign(:intranet_conversation, nil)
  end

  @impl true
  def handle_info({IntranetPhoenixProjectWeb.IntranetConversationLive.FormComponent, {:saved, intranet_conversation}}, socket) do
    {:noreply, stream_insert(socket, :intranet_conversations, intranet_conversation)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    intranet_conversation = Chats.get_intranet_conversation!(id)
    {:ok, _} = Chats.delete_intranet_conversation(intranet_conversation)

    {:noreply, stream_delete(socket, :intranet_conversations, intranet_conversation)}
  end
end
