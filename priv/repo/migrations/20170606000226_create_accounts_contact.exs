defmodule TillTax.Repo.Migrations.CreateTillTax.Accounts.Contact do
  use Ecto.Migration

  def change do
    create table(:accounts_contacts) do
      add :details, :map
      add :email, :string
      add :name, :string
      add :phone, :string

      timestamps()
    end

    create index(:accounts_contacts, [:email], unique: true)
  end
end
