require IEx

defmodule TillTax.Web.ContactController do
  use TillTax.Web, :controller

  alias TillTax.Accounts
  alias TillTax.Accounts.Contact

  action_fallback TillTax.Web.FallbackController

  def index(conn, _params) do
    contacts = Accounts.list_contacts()
    render(conn, "index.json", contacts: contacts)
  end

  def create(conn, %{
    "data" => %{
      "type" => "contacts",
      "attributes" => %{
        "details" => detailsString,
        "email" => email,
        "name" => name,
        "phone" => phone
      }
    }
  }) do
    details = Poison.Parser.parse!(detailsString || "{}")

    with {:ok, %Contact{} = contact} <- Accounts.create_contact(%{
      "details": details,
      "email": email,
      "name": name,
      "phone": phone
    }) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", contact_path(conn, :show, contact))
      |> render("show.json", contact: contact)
    end
  end

  def show(conn, %{"id" => id}) do
    contact = Accounts.get_contact!(id)
    render(conn, "show.json", contact: contact)
  end

  def update(conn, %{
    "id" => id,
    "data" => %{
      "type" => "contacts",
      "attributes" => %{
        "details" => detailsString,
        "email" => email,
        "name" => name,
        "phone" => phone
      }
    }
  }) do
    details = Poison.Parser.parse!(detailsString || "{}")
    contact = Accounts.get_contact!(id)

    with {:ok, %Contact{} = contact} <- Accounts.update_contact(contact, %{
      "details": details,
      "email": email,
      "name": name,
      "phone": phone
    }) do
      render(conn, "show.json", contact: contact)
    end
  end

  def delete(conn, %{"id" => id}) do
    contact = Accounts.get_contact!(id)
    with {:ok, %Contact{}} <- Accounts.delete_contact(contact) do
      send_resp(conn, :no_content, "")
    end
  end
end
