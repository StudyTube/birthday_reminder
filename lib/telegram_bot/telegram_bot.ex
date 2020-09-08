defmodule TelegramBot do
  use Supervisor

  def start_link(_init) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(TelegramBot.Poller, [[name: TelegramBot.Poller]]),
      worker(TelegramBot.Matcher, [[name: TelegramBot.Matcher]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
