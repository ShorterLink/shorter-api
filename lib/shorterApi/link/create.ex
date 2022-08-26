defmodule ShorterApi.Link.Create do
  alias ShorterApi.{Repo, Link}

  def call(params) do
    params
    |> Link.build()
    |> create_link()
  end

  defp create_link({:ok, struct}) do
    check = Repo.get_by(Link, hash: struct.hash)

    case check do
      nil -> Repo.insert(struct)
      _ -> create_link({:error, "Hash already taken"})
    end
  end

  defp create_link({:error, _} = error) do
    error
  end
end
