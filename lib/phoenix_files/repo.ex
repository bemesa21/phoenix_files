defmodule PhoenixFiles.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_files,
    adapter: Ecto.Adapters.Postgres
end
