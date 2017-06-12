defmodule TillTax.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias TillTax.Repo
  alias TillTax.Accounts.Contact
  alias TillTax.Accounts.User

  def for_token(contact = %Contact{}), do: { :ok, "Contact:#{contact.id}" }
  def for_token(user = %User{}), do: { :ok, "User:#{user.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("Contact:" <> id), do: { :ok, Repo.get(Contact, id) }
  def from_token("User:" <> id), do: { :ok, Repo.get(User, id) }
  def from_token(_), do: { :error, "Unknown resource type" }
end
