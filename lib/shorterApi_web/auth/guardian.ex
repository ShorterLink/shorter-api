defmodule ShorterApiWeb.Auth.Guardian do
  use Guardian, otp_app: :shorterApi

  alias ShorterApi.{Repo, User}

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    resource = ShorterApi.fetch_user(id)
    {:ok, resource}
  end

  def authenticate(%{"email" => email, "password" => password}) do
    case(Repo.get_by(User, email: email)) do
      nil -> {:error, :unauthorized}
      user -> validate_password(user, password)
    end
  end

  def authenticate(_) do
    {:error, "Usuario ou senha não informados"}
  end

  def validate_password(%User{password_hash: hash} = user, password) do
    case(Argon2.verify_pass(password, hash)) do
      true -> create_token(user)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, token}
  end
end
