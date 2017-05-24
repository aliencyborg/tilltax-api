defmodule TillTax.Web.AuthErrorHandler do
  use TillTax.Web, :controller

  def unauthenticated(conn, _) do
    conn
    |> put_status(401)
    |> render(TillTax.Web.ErrorView, :"401")
  end

  def unauthorized(conn, _) do
    conn
    |> put_status(403)
    |> render(TillTax.Web.ErrorView, :"403")
  end
end
