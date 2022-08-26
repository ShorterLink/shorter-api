defmodule ShorterApi.Link.Update do
  alias ShorterApi.{Repo, Link}
  alias Ecto.UUID

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, _uuid} -> update(params)
    end
  end

  defp update(%{"id" => uuid} = params) do
    case fetch_link(uuid) do
      nil -> {:error, "Link not found!"}
      link -> update_link(link, params)
    end
  end

  defp update_link(link, params) do
    link
    |> Link.changeset(params)
    |> Repo.update()
  end

  defp fetch_link(uuid) do
    Repo.get(Link, uuid)
  end
end
