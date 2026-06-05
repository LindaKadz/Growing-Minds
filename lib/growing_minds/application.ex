defmodule GrowingMinds.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GrowingMindsWeb.Telemetry,
      GrowingMinds.Repo,
      {DNSCluster, query: Application.get_env(:growing_minds, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GrowingMinds.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GrowingMinds.Finch},
      # Start a worker by calling: GrowingMinds.Worker.start_link(arg)
      # {GrowingMinds.Worker, arg},
      # Start to serve requests, typically the last entry
      GrowingMindsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GrowingMinds.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GrowingMindsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
