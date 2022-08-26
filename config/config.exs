# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :shorterApi,
  ecto_repos: [ShorterApi.Repo]

# Configures the endpoint
config :shorterApi, ShorterApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ShorterApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ShorterApi.PubSub,
  live_view: [signing_salt: "rF+/nH0V"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :shorterApi, ShorterApi.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :shorterApi, ShorterApiWeb.Auth.Pipeline,
  module: ShorterApiWeb.Auth.Guardian,
  error_handler: ShorterApiWeb.Auth.ErrorHandler

# Import secret configs
import_config "#{Mix.env()}.secret.exs"
