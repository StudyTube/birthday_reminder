defmodule BirthdayReminder.Cache do
  use GenServer

  # Server

  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:get, key}, _, state) do
    value = Map.get(state, key)
    {:reply, value, state}
  end

  def handle_call({:insert, {key, value}}, _ref, state) do
    map = Map.put(state, key, value)
    {:reply, :ok, map}
  end

  def handle_call({:delete, key}, _ref, state) do
    map = Map.delete(state, key)
    {:reply, :ok, map}
  end

  # Client

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def insert(key, value) do
    GenServer.call(__MODULE__, {:insert, {key, value}})
  end

  def delete(key) do
    GenServer.call(__MODULE__, {:delete, key})
  end
end
