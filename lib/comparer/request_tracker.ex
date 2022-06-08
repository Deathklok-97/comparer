defmodule RequestTracker do
  use GenServer

  def start_link(version) do
    GenServer.start_link(__MODULE__, {:ok, version}, name: :"version_#{version}")
  end

  def set_request(pid, req), do: GenServer.call(pid, {:set, req})
  def dump_state(pid), do: GenServer.call(pid, :dump)
  def reset(pid), do: GenServer.call(pid, :reset)

  def init({:ok, version}), do: {:ok, %{:version => version}}
  def handle_call({:set, req}, _from, state) do
    new_state = Map.merge(req, state)

    {:reply, new_state, new_state }
  end

  def handle_call(:dump, _from, state), do: {:reply, state, state}
  
  def handle_call(:reset, _from, state) do
    new_state = Map.take(state, [:version])

  {:reply, new_state, new_state}
  end

end
