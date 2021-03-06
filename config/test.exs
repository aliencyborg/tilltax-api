use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tilltax, TillTax.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tilltax, TillTax.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "tilltax_test",
  hostname: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure bamboo mailer
config :tilltax, TillTax.Mailer,
  adapter: Bamboo.TestAdapter

# Reduce the BCrypt rounds for speed
config :comeonin, :bcrypt_log_rounds, 4
