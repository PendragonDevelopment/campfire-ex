# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :campfire,
  ecto_repos: [Campfire.Repo]

# Configures the endpoint
config :campfire, CampfireWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fg1D17sPWW/WVdKmVJL+HUE6gyFEjk/335N9Ag65AZNwbaFFe+cnTUKNZfnxhJS0",
  render_errors: [view: CampfireWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Campfire.PubSub,
  live_view: [signing_salt: "60oPMavS"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
