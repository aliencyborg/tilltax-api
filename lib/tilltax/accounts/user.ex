defmodule TillTax.Accounts.User do
  use Ecto.Schema

  schema "accounts_users" do
    field :email, :string
    field :password_hash, :string

    timestamps()
  end
end
