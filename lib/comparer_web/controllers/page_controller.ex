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
    pid = [GenServer.whereis(:version_1), GenServer.whereis(:version_2)]
    [state, state_2] = pid
    |> Enum.map(&RequestTracker.dump_state(&1))
    |> Enum.map(&Map.delete(&1, :version))

    differences = MapDiff.diff(state, state_2)

    conn
    |> put_status(:ok)
    |> json(differences)
  end

  def reset(conn, _params) do
    pid = [GenServer.whereis(:version_1), GenServer.whereis(:version_2)]
    pid |> Enum.map(&RequestTracker.reset(&1))

    conn
    |> put_status(:ok)
    |> json(%{ :message => "a-okay"})
  end
end
