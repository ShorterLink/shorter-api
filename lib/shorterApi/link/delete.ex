defmodule ShorterApi.Link.Delete do
  alias ShorterApi.{Repo, Link}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(uuid) do
    case fetch_link(uuid) do
      nil -> {:error, "Link not found!"}
      link -> Repo.delete(link)
    end
  end

  defp fetch_link(uuid) do
    Repo.get(Link, uuid)
  end
end
