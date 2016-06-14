# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :tbforwarder, Tbforwarder.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "example",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Tbforwarder.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Teachbase Endpoint API credentials
config :tbforwarder, 
       :teachbase,
       client_id: "937493fc1ae028e5c8b78d7c5608aa456cb8d4e0dccc5b085be1ee513bc469ad",
       client_secret: "3dbfc66bbf13f4cf987818e9bb127c4a74ac927b9e8c067bbcf133b528d9ab4d",
       token_url: "http://127.0.0.1:3001/oauth/token"
       host: "http://127.0.0.1:3001"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
