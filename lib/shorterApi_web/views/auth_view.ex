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

  def render("me.json", %{
        user: %User{id: id, name: name, email: email, inserted_at: inserted_at},
        token: token
      }) do
    %{
      user: %{
        id: id,
        name: name,
        email: email,
        inserted_at: inserted_at
      },
      token: token
    }
  end
end
