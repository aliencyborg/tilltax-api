defmodule TillTax.Web.UserController do
  use TillTax.Web, :controller

  alias TillTax.Accounts

  action_fallback TillTax.Web.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, handler: TillTax.Web.AuthErrorHandler

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def current(conn, _) do
    user = conn
    |> Guardian.Plug.current_resource

    render(conn, "show.json", user: user)
  end
end
