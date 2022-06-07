defmodule ComparerWeb.PageController do
  use ComparerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def track(conn, params) do
    pid1 = GenServer.whereis(:version_1)
    pid2 = GenServer.whereis(:version_2)

      case Map.get(conn.assigns, :version) do
        "1" -> RequestTracker.set_request(pid1, params)
        "2" -> RequestTracker.set_request(pid2, params)
      end

    conn
    |> put_status(:ok)
    |> json(params)

  end


  def compare(conn, _params) do
    differences = %{}  #MapDiff.diff(request_1, request_2)

    conn
    |> put_status(:ok)
    |> json(differences)
  end
end
