# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tilltax,
  namespace: TillTax,
  ecto_repos: [TillTax.Repo]

# Configures the endpoint
config :tilltax, TillTax.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XWguv2Os5mpTe7Tmr9nK0KoXqaUdqF1td1aRmYpYev5UmXWIoL2IIk7ujZOVDAJo",
  render_errors: [view: TillTax.Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: TillTax.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
