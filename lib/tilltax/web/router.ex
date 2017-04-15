defmodule TillTax.Web.Router do
  use TillTax.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  scope "/", TillTax.Web do
    pipe_through :api
    resources "/session", SessionController, only: [:index]
  end
end
