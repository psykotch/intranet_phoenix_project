defmodule IntranetPhoenixProject.Repo do
  use Ecto.Repo,
    otp_app: :intranet_phoenix_project,
    adapter: Ecto.Adapters.Postgres
end
