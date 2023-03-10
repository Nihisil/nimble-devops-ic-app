import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :sample_app, SampleApp.Repo,
  username: "postgres",
  password: "postgres",
  hostname: System.get_env("DB_HOST") || "localhost",
  database: "sample_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sample_app, SampleAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "nQmO+5zP1zubtJTZwx1+GWcSxxba2M10lzuG9127YSxUKKRck+AkF35V3fcUsxUP",
  server: true

config :sample_app, :sql_sandbox, true

config :wallaby,
  otp_app: :sample_app,
  chromedriver: [headless: System.get_env("CHROME_HEADLESS", "true") === "true"],
  screenshot_dir: "tmp/wallaby_screenshots",
  screenshot_on_failure: true

# In test we don't send emails.
config :sample_app, SampleApp.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :sample_app, cache_adapter: Nebulex.Adapters.Nil
