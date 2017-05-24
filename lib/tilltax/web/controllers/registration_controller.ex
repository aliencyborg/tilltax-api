defmodule TillTax.Web.RegistrationController do
  use TillTax.Web, :controller

  alias TillTax.Accounts
  alias TillTax.Accounts.User
  alias TillTax.Web.UserView

  action_fallback TillTax.Web.FallbackController

  def create(conn, %{
    "data" => %{
      "type" => "users",
      "attributes" => %{
        "email" => email,
        "password" => password,
        "password-confirmation" => password_confirmation
      }
    }
  }) do
    with {:ok, %User{} = user} <- Accounts.create_user(%{
      email: email,
      password: password,
      password_confirmation: password_confirmation
    }) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render(UserView, "show.json", user: user)
    end
  end
end
