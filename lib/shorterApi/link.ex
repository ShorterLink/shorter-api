defmodule ShorterApi.Link do
  use Ecto.Schema
  import Ecto.Changeset
  import Logger

  alias ShorterApi.{User, Repo, Link}

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "links" do
    field :name, :string
    field :url, :string
    field :hash, :string
    field :clicks, :integer
    field :enabled, :boolean
    belongs_to(:users, User)
    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  @required_params [:name, :url]
  @all_params [:name, :hash, :url, :users_id, :clicks, :enabled]

  def changeset(params), do: create_changeset(%__MODULE__{}, params, @required_params)
  def changeset(link, params), do: create_changeset(link, params, [])

  defp create_changeset(module_or_link, params, required) do
    module_or_link
    |> cast(params, @all_params)
    |> validate_required(required)
    |> validate_length(:url, min: 8)
  end

  def check_hash_exist(hash, count) do
    check = Repo.get_by(Link, hash: hash)

    if count >= 999 do
      Logger.error("Cant generate a unique new hash, please check your database!")
      {:error, "Error"}
    else
      case check do
        nil -> hash
        _ -> generate_hash(count + 1)
      end
    end
  end

  def generate_hash() do
    generate_hash(0)
  end

  def generate_hash(count) do
    hash =
      for _ <- 1..6,
          into: "",
          do: <<Enum.random('0123456789abcdefABCDEFGH')>>

    check_hash_exist(hash, count)
  end
end
