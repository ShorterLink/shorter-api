defmodule ShorterApiWeb.AuthController do
  use ShorterApiWeb, :controller

  alias ShorterApiWeb.Auth.Guardian

  action_fallback ShorterApiWeb.FallbackController

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", %{token: token})
    end
  end

  def me(conn, params) do
    token = get_token(conn)

    result = Guardian.decode_and_verify(token)

    case result do
      {:ok, claims} -> valid_session(conn, token)
      _ -> text(conn, "error")
    end
  end

  defp valid_session(conn, token) do
    {:ok, resource, claims} = Guardian.resource_from_token(token)
    IO.inspect(resource)

    {:ok, user} = resource

    conn
    |> render("me.json", %{user: user, token: token})
  end

  defp get_token(conn) do
    token =
      get_req_header(conn, "authorization")
      |> Enum.at(0)
      |> String.split(" ")
      |> Enum.at(1)
  end

  defp handle_delete({:ok, _user}, conn) do
    conn
    |> put_status(:no_content)
    |> text("")
  end

  defp handle_delete({:error, _reason} = error, _conn) do
    error
  end

  defp handle_response({:ok, user}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, user: user)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status) do
    error
  end
end
