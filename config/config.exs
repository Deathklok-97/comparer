# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :comparer, ComparerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+vQP4+COTjZYMdhk3M3+EVNgSGCltZk/fzvjFUIZo9K4c6Hogk8n7DYbdRrfwwq5",
  render_errors: [view: ComparerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Comparer.PubSub,
  live_view: [signing_salt: "z9RwKChi"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
