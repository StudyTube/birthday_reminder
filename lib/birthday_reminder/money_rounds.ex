defmodule BirthdayReminder.MoneyRounds do
  import Ecto.Query, warn: false

  alias BirthdayReminder.{Repo, MoneyRound}

  def current_rounds do
    query = from mr in MoneyRound,
      where: fragment("current_date < ?", mr.expired_date),
      order_by: [desc: mr.inserted_at]

    Repo.all(query)
  end

  def past_rounds do
    query = from mr in MoneyRound,
      where: fragment("current_date > ?", mr.expired_date),
      order_by: [desc: mr.expired_date]

    Repo.all(query)
  end

  def create_money_round(attrs \\ %{}) do
    %MoneyRound{}
    |> MoneyRound.changeset(attrs)
    |> Repo.insert!
  end

  def update_money_round(%MoneyRound{} = money_round, attrs) do
    money_round
    |> MoneyRound.changeset(attrs)
    |> Repo.update()
  end
end
