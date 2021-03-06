defmodule Comparer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ComparerWeb.Telemetry,
      Supervisor.child_spec({RequestTracker, "1"}, id: :version_1),
      Supervisor.child_spec({RequestTracker, "2"}, id: :version_2),
      # Start the PubSub system
      {Phoenix.PubSub, name: Comparer.PubSub},
      # Start the Endpoint (http/https)
      ComparerWeb.Endpoint
      # Start a worker by calling: Comparer.Worker.start_link(arg)
      # {Comparer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Comparer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ComparerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
