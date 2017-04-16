defmodule TillTax.Web.SessionController do
  use TillTax.Web, :controller

  # alias TillTax.Accounts
  # alias TillTax.Accounts.Session

  action_fallback TillTax.Web.FallbackController

  def index(conn, _params) do
    conn
    |> json(%{status: "Ok"})
  end
end
