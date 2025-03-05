defmodule IntranetPhoenixProject.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      IntranetPhoenixProjectWeb.Telemetry,
      IntranetPhoenixProject.Repo,
      {DNSCluster, query: Application.get_env(:intranet_phoenix_project, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: IntranetPhoenixProject.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: IntranetPhoenixProject.Finch},
      # Start a worker by calling: IntranetPhoenixProject.Worker.start_link(arg)
      # {IntranetPhoenixProject.Worker, arg},
      # Start to serve requests, typically the last entry
      IntranetPhoenixProjectWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IntranetPhoenixProject.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IntranetPhoenixProjectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
