defmodule ShorterApiWeb.FallbackController do
  use ShorterApiWeb, :controller

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ShorterApiWeb.ErrorView)
    |> render("401.json", message: "User unauthorized")
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ShorterApiWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
