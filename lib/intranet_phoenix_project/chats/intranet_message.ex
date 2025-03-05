defmodule IntranetPhoenixProject.Chats.IntranetMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "intranet_messages" do
    field :body, :string
    field :conversation_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(intranet_message, attrs) do
    intranet_message
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
