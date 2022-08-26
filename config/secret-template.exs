import Config

config :shorterApi, ShorterApiWeb.Auth.Guardian,
  issuer: "shorterApi",
  secret_key: "your-key"

config :shorterApi, ShorterApiWeb.Endpoint, secret_key_base: "your-key"

config :shorterApi, ShorterApi.Repo,
  username: "postgres",
  password: "shorter",
  hostname: "localhost",
  database: "shorter"
