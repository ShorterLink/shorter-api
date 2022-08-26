defmodule ShorterApiWeb.UsersView do
  use ShorterApiWeb, :view
  alias ShorterApi.User

  def render("create.json", %{
        user: %User{id: id, name: name, email: email, inserted_at: inserted_at},
        token: token
      }) do
    %{
      message: "User created!",
      user: %{
        id: id,
        name: name,
        email: email,
        inserted_at: inserted_at
      },
      token: token
    }
  end

  def render("update.json", %{
        user: %User{id: id, name: name, email: email, inserted_at: inserted_at}
      }) do
    %{
      message: "User updated!",
      user: %{
        id: id,
        name: name,
        email: email,
        inserted_at: inserted_at
      }
    }
  end

  def render("show.json", %{
        user: %User{id: id, name: name, email: email, inserted_at: inserted_at}
      }) do
    %{
      id: id,
      name: name,
      email: email,
      inserted_at: inserted_at
    }
  end

  def render("show.json", %{
        user: %{id: id, name: name, email: email, inserted_at: inserted_at}
      }) do
    %{
      id: id,
      name: name,
      email: email,
      inserted_at: inserted_at
    }
  end
end
