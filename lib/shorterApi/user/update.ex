defmodule ShorterApi.User.Update do
  alias ShorterApi.{Repo, User}
  alias Ecto.UUID

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, _uuid} -> update(params)
    end
  end

  defp update(%{"id" => uuid} = params) do
    case fetch_user(uuid) do
      nil -> {:error, "User not found!"}
      user -> update_trainer(user, params)
    end
  end

  defp update_trainer(trainer, params) do
    trainer
    |> User.changeset(params)
    |> Repo.update()
  end

  defp fetch_user(uuid) do
    Repo.get(User, uuid)
  end
end
