defmodule ShorterApi.Link.Get do
  alias ShorterApi.{Repo, Link}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> get_by_hash(id)
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case fetch_link(uuid, false) do
      nil -> {:error, "Link not found!"}
      link -> {:ok, link}
    end
  end

  defp get_by_hash(hash) do
    case fetch_link("", hash) do
      nil -> {:error, "Link not found!"}
      link -> {:ok, link}
    end
  end

  defp fetch_link(uuid, hash) do
    case hash do
      false -> Repo.get(Link, uuid)
      _ -> Repo.get_by(Link, hash: hash)
    end
  end
end
