defmodule ShorterApi.Repo do
  use Ecto.Repo,
    otp_app: :shorterApi,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 5
end
