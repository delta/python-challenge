defmodule PythonChallenge.Repo do
  use Ecto.Repo,
    otp_app: :python_challenge,
    adapter: Ecto.Adapters.Postgres
end
