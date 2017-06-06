defmodule TillTax.Repo.Migrations.CreateTillTax.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :admin, :boolean
      add :email, :string
      add :password_hash, :string
      add :phone, :string

      timestamps()
    end

    create index(:accounts_users, [:email], unique: true)
  end
end
