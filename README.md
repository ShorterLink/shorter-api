# Shorter - API

## Running server (development)

Install dependencies:

```bash
mix deps.get
```

Run `postgres` container (or use your postgres instance):

```bash
docker build -t shorter-database .

docker run -d --name shorter-db -p 5432:5432 shorter-databse
```

Create and setup your config file:

> create file `dev.secret.exs` on `config/` folder and copy the `secret-template.exs` content:

```elixir
import Config

config :shorterApi, ShorterApiWeb.Auth.Guardian,
  issuer: "shorterApi",
  secret_key: "your-key"

config :shorterApi, ShorterApiWeb.Endpoint,
  secret_key_base: "your-key"
```

Adjust the `config.exs` settings:

```elixir
...
config :shorterApi,
  ...
  front_base_url: "http://localhost"
  ...
```

> you can generate new keys with `mix phx.gen.secret` and copy it.

Migrate your database:

```bash
mix ecto.migrate
```

Seed your database:

```bash
mix run priv/repo/seeds.exs
```

Start Server:

```bash
mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
