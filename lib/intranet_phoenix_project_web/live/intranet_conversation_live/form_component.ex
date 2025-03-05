defmodule IntranetPhoenixProjectWeb.IntranetConversationLive.FormComponent do
  use IntranetPhoenixProjectWeb, :live_component

  alias IntranetPhoenixProject.Chats

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage intranet_conversation records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="intranet_conversation-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input
          field={@form[:type]}
          type="select"
          label="Type"
          prompt="Choose a value"
          options={Ecto.Enum.values(IntranetPhoenixProject.Chats.IntranetConversation, :type)}
        />
        <.input
          field={@form[:status]}
          type="select"
          label="Status"
          prompt="Choose a value"
          options={Ecto.Enum.values(IntranetPhoenixProject.Chats.IntranetConversation, :status)}
        />
        <.input field={@form[:topic]} type="text" label="Topic" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Intranet conversation</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{intranet_conversation: intranet_conversation} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Chats.change_intranet_conversation(intranet_conversation))
     end)}
  end

  @impl true
  def handle_event("validate", %{"intranet_conversation" => intranet_conversation_params}, socket) do
    changeset = Chats.change_intranet_conversation(socket.assigns.intranet_conversation, intranet_conversation_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"intranet_conversation" => intranet_conversation_params}, socket) do
    save_intranet_conversation(socket, socket.assigns.action, intranet_conversation_params)
  end

  defp save_intranet_conversation(socket, :edit, intranet_conversation_params) do
    case Chats.update_intranet_conversation(socket.assigns.intranet_conversation, intranet_conversation_params) do
      {:ok, intranet_conversation} ->
        notify_parent({:saved, intranet_conversation})

        {:noreply,
         socket
         |> put_flash(:info, "Intranet conversation updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_intranet_conversation(socket, :new, intranet_conversation_params) do
    case Chats.create_intranet_conversation(intranet_conversation_params) do
      {:ok, intranet_conversation} ->
        notify_parent({:saved, intranet_conversation})

        {:noreply,
         socket
         |> put_flash(:info, "Intranet conversation created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
