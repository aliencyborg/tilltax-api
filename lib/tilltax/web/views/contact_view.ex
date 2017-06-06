defmodule TillTax.Web.ContactView do
  use TillTax.Web, :view
  alias TillTax.Web.ContactView

  def render("index.json", %{contacts: contacts}) do
    %{data: render_many(contacts, ContactView, "contact.json")}
  end

  def render("show.json", %{contact: contact}) do
    %{data: render_one(contact, ContactView, "contact.json")}
  end

  def render("contact.json", %{contact: contact}) do
    %{
      type: "contact",
      id: contact.id,
      attributes: %{
        name: contact.name,
        email: contact.email,
        phone: contact.phone,
        details: contact.details
      }
    }
  end
end
