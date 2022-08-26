defmodule ShorterApi.User.Get do
  alias ShorterApi.{Repo, User}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case fetch_user(uuid) do
      nil -> {:error, "User not found!"}
      user -> {:ok, user}
    end
  end

  defp fetch_user(uuid) do
    Repo.get(User, uuid)
  end
end
