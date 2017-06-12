defmodule TillTax.Accounts.Contact do
  use Ecto.Schema
  import Ecto.Changeset
  alias TillTax.Accounts.Contact


  schema "accounts_contacts" do
    field :details, :map
    field :email, :string
    field :name, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(%Contact{} = contact, attrs) do
    contact
    |> cast(attrs, [:details, :email, :name, :phone])
    |> validate_required([:details, :email, :name, :phone])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, max: 100, min: 2)
    |> validate_length(:email, max: 100)
    |> unique_constraint(:email)
  end
end
