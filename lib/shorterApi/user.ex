defmodule ShorterApi.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ShorterApi.Link

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_many(:links, Link, foreign_key: :users_id)
    timestamps()
  end

  @required_params [:name, :email, :password]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params, @required_params)
  def changeset(user, params), do: create_changeset(user, params, [])

  defp create_changeset(module_or_user, params, required) do
    module_or_user
    |> cast(params, required)
    |> validate_required(required)
    |> validate_length(:name, min: 5)
    |> validate_length(:email, min: 5)
    |> validate_length(:password, min: 5)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
