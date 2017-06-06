defmodule TillTax.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TillTax.Accounts.User


  schema "accounts_users" do
    field :admin, :boolean
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:admin, :email, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> hash_password
    |> unique_constraint(:email)
  end

  defp hash_password(%{valid?: false} = changeset), do: changeset
  defp hash_password(%{valid?: true} = changeset) do
    hashedpw = Comeonin.Bcrypt.hashpwsalt(
      Ecto.Changeset.get_field(changeset, :password)
    )
    Ecto.Changeset.put_change(changeset, :password_hash, hashedpw)
  end
end
