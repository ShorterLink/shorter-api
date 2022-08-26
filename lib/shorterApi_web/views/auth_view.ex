defmodule ShorterApiWeb.AuthView do
  use ShorterApiWeb, :view
  alias ShorterApi.User

  def render("create.json", %{
        token: token
      }) do
    %{
      token: token
    }
  end
end
