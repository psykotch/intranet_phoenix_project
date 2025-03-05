defmodule IntranetPhoenixProject.ChatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IntranetPhoenixProject.Chats` context.
  """

  @doc """
  Generate a intranet_conversation.
  """
  def intranet_conversation_fixture(attrs \\ %{}) do
    {:ok, intranet_conversation} =
      attrs
      |> Enum.into(%{
        status: :active,
        topic: "some topic",
        type: :public
      })
      |> IntranetPhoenixProject.Chats.create_intranet_conversation()

    intranet_conversation
  end
end
