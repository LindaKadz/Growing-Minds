defmodule GrowingMinds.Repo do
  use Ecto.Repo,
    otp_app: :growing_minds,
    adapter: Ecto.Adapters.Postgres
end
