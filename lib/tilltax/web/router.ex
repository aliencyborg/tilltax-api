defmodule TillTax.Web.Router do
  use TillTax.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  scope "/", TillTax.Web do
    pipe_through :api

    post "/register", RegistrationController, :create
    post "/token", SessionController, :create, as: :login

    resources "/users", UserController, except: [:new, :edit]
  end
end
