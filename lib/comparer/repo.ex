defmodule Comparer.Repo do
  use Ecto.Repo,
    otp_app: :comparer,
    adapter: Ecto.Adapters.Postgres
end
