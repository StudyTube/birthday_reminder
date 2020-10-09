defmodule BirthdayReminder.Cache do
  use GenServer

  @name :postgres_cache

  # Server

  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  def init(_) do
    :ets.new(@name, [:set, :named_table, :public, read_concurrency: true, write_concurrency: true])
    {:ok, []}
  end

  def handle_call({:get, key}, _, state) do
    [{key, data}] = :ets.lookup(@name, key)
    {:reply, data, state}
  end

  def handle_call({:insert, data}, _ref, state) do
    :ets.insert(@name, data)
    {:reply, :ok, state}
  end

  def handle_call({:delete, key}, _ref, state) do
    :ets.delete(@name, key)
    {:reply, :ok, state}
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
