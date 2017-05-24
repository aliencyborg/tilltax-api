defmodule TillTax.Web.SessionController do
  use TillTax.Web, :controller

  import Ecto.Query, only: [where: 2]
  import Comeonin.Bcrypt

  require Logger

  alias TillTax.Repo
  alias TillTax.Accounts.User

  action_fallback TillTax.Web.FallbackController

  def create(conn, %{
    "grant_type" => "password",
    "username" => username,
    "password" => password
  }) do

    try do
      user = User
      |> where(email: ^username)
      |> Repo.one!
      cond do

        checkpw(password, user.password_hash) ->
          Logger.info "User " <> username <> " successfully logged in"
          {:ok, jwt, _} = Guardian.encode_and_sign(user, :token)
          conn
          |> json(%{access_token: jwt})

        true ->
          Logger.warn "User " <> username <> " failed to log in"
          conn
          |> put_status(:unauthorized)
          |> render(TillTax.Web.ErrorView, :"401")

      end

    rescue
      e ->
        IO.inspect e
        Logger.error "Unexpected error while attempting to log in user " <> username
        conn
        |> put_status(:unauthorized)
        |> render(TillTax.Web.ErrorView, :"401")
    end

  end
end
