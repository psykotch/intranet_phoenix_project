defmodule IntranetPhoenixProject.Repo.Migrations.CreateIntranetMessages do
  use Ecto.Migration

  def change do
    create table(:intranet_messages) do
      add :body, :string
      add :conversation_id, references(:intranet_conversations, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:intranet_messages, [:conversation_id])
  end
end
