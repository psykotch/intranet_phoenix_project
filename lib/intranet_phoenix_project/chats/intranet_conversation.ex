defmodule IntranetPhoenixProject.Chats.IntranetConversation do
  @moduledoc """
    Chats context with conversation table and its atribbutes
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "intranet_conversations" do
    field :status, Ecto.Enum, values: [:active, :archived]
    field :type, Ecto.Enum, values: [:public, :private]
    field :topic, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(intranet_conversation, attrs) do
    intranet_conversation
    |> cast(attrs, [:type, :status, :topic])
    |> validate_required([:type, :status, :topic])
  end
end
