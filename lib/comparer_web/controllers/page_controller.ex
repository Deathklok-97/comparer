defmodule ComparerWeb.PageController do
  use ComparerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def track(conn, params) do

    IO.inspect(conn.assigns, label: "conn assigns")


    conn
    |> put_status(:ok)
    |> json(params)

  end
end
