defmodule ShorterApi.Link.GetAll do
  import Ecto.Query, only: [where: 3, order_by: 2]
  alias ShorterApi.{Repo, Link}
  alias Ecto.UUID

  def call(params) do
    params
    |> get_all()
  end

  defp get_all(params) do
    case fetch_all_link(params) do
      nil -> {:error, "Links not found!"}
      link -> {:ok, link}
      _ -> {:error, "Links not found!"}
    end
  end

  defp fetch_all_link(params) do
    params =
      params
      |> Map.put_new("page_number", 1)
      |> Map.put_new("page_size", 5)
      |> Map.put_new("show_disabled", false)

    Link
    |> order_by(desc: :inserted_at)
    |> Repo.paginate(page: params["page_number"], page_size: params["page_size"])
  end
end
