defmodule BirthdayReminder.MoneyRounds.Services.GetCurrentRounds do
  @moduledoc false

  import Ecto.Query, only: [order_by: 3, where: 3]

  alias BirthdayReminder.MoneyRounds.Schemas.MoneyRound
  alias BirthdayReminder.Repo

  @doc """
  Returns list of money rounds before day X.

  ## Examples

    iex> GetCurrentRounds.call()
    [%User{}, ...]
  """
  @spec call() :: list(MoneyRound.t())
  def call() do
    MoneyRound
    |> where([mr], fragment("current_date <= ?", mr.expired_date))
    |> order_by([mr], desc: mr.inserted_at)
    |> Repo.all
  end
end
