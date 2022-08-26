import Config

database_url =
  System.get_env("SORTER_DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

secret_key =
  System.get_env("SORTER_SECRET_KEY") ||
    raise """
    environment variable SORTER_SECRET_KEY is missing.
    You can generate one by calling: mix phx.gen.secret
    """

secret_key_base =
  System.get_env("SORTER_SECRET_KEY_BASE") ||
    raise """
    environment variable SORTER_SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

port =
  System.get_env("SORTER_PORT") ||
    raise """
    environment variable SORTER_PORT is missing.
    """

config :shorterApi, ShorterApiWeb.Auth.Guardian,
  issuer: "shorterApi",
  secret_key: secret_key

config :shorterApi, ShorterApiWeb.Endpoint, secret_key_base: secret_key_base

config :shorterApi, ShorterApiWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: port || 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: nil,
  watchers: []
