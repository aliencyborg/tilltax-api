defmodule TillTax.Accounts.Email do
  alias TillTax.Mailer
  use Bamboo.Phoenix, view: TillTax.Web.EmailView
  import Bamboo.SendgridHelper

  def welcome_email(contact) do
    years = Enum.join(contact.details["filingYears"], ", ")

    new_email()
    |> to(contact.email)
    |> from("admin@tilltax.com")
    |> with_template(System.get_env("SENDGRID_WELCOME_TEMPLATE"))
    |> substitute("%name%", contact.name)
    |> substitute("%email%", contact.email)
    |> substitute("%phone%", contact.phone)
    |> substitute("%status%", contact.details["filingStatus"])
    |> substitute("%state%", contact.details["filingRegion"])
    |> substitute("%years%", years)
    |> Mailer.deliver_later
  end

  def new_contact_email(email_address) do
    new_email()
    |> to(email_address)
    |> from("admin@tilltax.com")
    |> with_template(System.get_env("SENDGRID_NEW_CONTACT_TEMPLATE"))
    |> Mailer.deliver_later
  end

  def report_email(email_address) do
    new_email()
    |> to(email_address)
    |> from("admin@tilltax.com")
    |> with_template(System.get_env("SENDGRID_REPORT_TEMPLATE"))
    |> Mailer.deliver_later
  end
end
