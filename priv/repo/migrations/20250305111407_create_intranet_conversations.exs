defmodule IntranetPhoenixProject.Repo.Migrations.CreateIntranetConversations do
  use Ecto.Migration

  def change do
    create table(:intranet_conversations) do
      add :type, :string
      add :status, :string
      add :topic, :string

      timestamps(type: :utc_datetime)
    end
  end
end
