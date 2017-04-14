defmodule TillTax.Repo.Migrations.CreateTillTax.Accounts.Session do
  use Ecto.Migration

  def change do
    create table(:accounts_sessions) do

      timestamps()
    end

  end
end
