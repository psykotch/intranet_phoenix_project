defmodule IntranetPhoenixProject.ChatsTest do
  use IntranetPhoenixProject.DataCase

  alias IntranetPhoenixProject.Chats

  describe "intranet_conversations" do
    alias IntranetPhoenixProject.Chats.IntranetConversation

    import IntranetPhoenixProject.ChatsFixtures

    @invalid_attrs %{status: nil, type: nil, topic: nil}

    test "list_intranet_conversations/0 returns all intranet_conversations" do
      intranet_conversation = intranet_conversation_fixture()
      assert Chats.list_intranet_conversations() == [intranet_conversation]
    end

    test "get_intranet_conversation!/1 returns the intranet_conversation with given id" do
      intranet_conversation = intranet_conversation_fixture()
      assert Chats.get_intranet_conversation!(intranet_conversation.id) == intranet_conversation
    end

    test "create_intranet_conversation/1 with valid data creates a intranet_conversation" do
      valid_attrs = %{status: :active, type: :public, topic: "some topic"}

      assert {:ok, %IntranetConversation{} = intranet_conversation} = Chats.create_intranet_conversation(valid_attrs)
      assert intranet_conversation.status == :active
      assert intranet_conversation.type == :public
      assert intranet_conversation.topic == "some topic"
    end

    test "create_intranet_conversation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_intranet_conversation(@invalid_attrs)
    end

    test "update_intranet_conversation/2 with valid data updates the intranet_conversation" do
      intranet_conversation = intranet_conversation_fixture()
      update_attrs = %{status: :archived, type: :private, topic: "some updated topic"}

      assert {:ok, %IntranetConversation{} = intranet_conversation} = Chats.update_intranet_conversation(intranet_conversation, update_attrs)
      assert intranet_conversation.status == :archived
      assert intranet_conversation.type == :private
      assert intranet_conversation.topic == "some updated topic"
    end

    test "update_intranet_conversation/2 with invalid data returns error changeset" do
      intranet_conversation = intranet_conversation_fixture()
      assert {:error, %Ecto.Changeset{}} = Chats.update_intranet_conversation(intranet_conversation, @invalid_attrs)
      assert intranet_conversation == Chats.get_intranet_conversation!(intranet_conversation.id)
    end

    test "delete_intranet_conversation/1 deletes the intranet_conversation" do
      intranet_conversation = intranet_conversation_fixture()
      assert {:ok, %IntranetConversation{}} = Chats.delete_intranet_conversation(intranet_conversation)
      assert_raise Ecto.NoResultsError, fn -> Chats.get_intranet_conversation!(intranet_conversation.id) end
    end

    test "change_intranet_conversation/1 returns a intranet_conversation changeset" do
      intranet_conversation = intranet_conversation_fixture()
      assert %Ecto.Changeset{} = Chats.change_intranet_conversation(intranet_conversation)
    end
  end
end
