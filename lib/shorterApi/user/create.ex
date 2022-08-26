defmodule ShorterApi.User.Create do
  alias ShorterApi.{Repo, User}

  def call(params) do
    params
    |> User.build()
    |> create_user()
  end

  defp create_user({:ok, struct}) do
    check = Repo.get_by(User, email: struct.email)

    case check do
      nil -> Repo.insert(struct)
      _ -> create_user({:error, "Email already taken"})
    end
  end

  defp create_user({:error, _changeset} = error) do
    error
  end

  defp create_user({:error, message} = error) do
    message
  end
end
