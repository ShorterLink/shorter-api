defmodule ShorterApiWeb.UsersController do
  use ShorterApiWeb, :controller

  alias ShorterApi.User
  alias ShorterApiWeb.Auth.Guardian

  action_fallback ShorterApiWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- ShorterApi.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", %{user: user, token: token})
    end
  end

  def update(conn, params) do
    params
    |> ShorterApi.update_user()
    |> handle_response(conn, "update.json", :ok)
  end

  def delete(conn, %{"id" => id}) do
    id
    |> ShorterApi.delete_user()
    |> handle_delete(conn)
  end

  def show(conn, %{"id" => id}) do
    id
    |> ShorterApi.fetch_user()
    |> handle_response(conn, "show.json", :ok)
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
