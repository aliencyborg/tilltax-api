defmodule TillTax.Web.Router do
  use TillTax.Web, :router

  # Unauthenticated Requests
  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  # Authenticated Requests
  pipeline :api_auth do
    plug :accepts, ["json", "json-api"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/", TillTax.Web do
    pipe_through :api

    post "/contact", ContactController, :create
    post "/register", RegistrationController, :create
    post "/token", SessionController, :create, as: :login
  end

  scope "/", TillTax.Web do
    pipe_through :api_auth

    get "/user/current", UserController, :current

    resources "/contact", ContactController, except: [:new, :edit]
    resources "/user", UserController, except: [:new, :edit]
  end
end
