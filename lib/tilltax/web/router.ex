defmodule TillTax.Web.Router do
  use TillTax.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TillTax.Web do
    pipe_through :api
  end
end
