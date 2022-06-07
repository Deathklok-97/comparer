defmodule Comparer.Plugs.SetVersion do
  import Plug.Conn
  import Phoenix.Controller

  @versions ["1", "2"]

  def init(_params), do: "1"

  def call(conn, default_version) do
    version = case get_req_header(conn, "version") do
      [version] when version in @versions -> version
      _ -> default_version
    end
    IO.inspect(version, label: "plug ver")
    assign(conn, :version, version)
  end
end
