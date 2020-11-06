defmodule BirthdayReminder.MoneyRounds do
  import Ecto.Query, warn: false

  alias BirthdayReminder.{MoneyRound, Repo, User}

  def current_rounds do
    query = from mr in MoneyRound,
      where: fragment("current_date <= ?", mr.expired_date),
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
    |> broadcast(:money_round_updated)
  end

  def confirm_payment(chat_id, identifier) do
    user = Repo.get_by(User, chat_id: chat_id)
    money_round = Repo.get_by(MoneyRound, identifier: identifier)
    update_money_round(money_round, %{usernames: [user.username|money_round.usernames]})

    chat_id
  end

  def subscribe do
    Phoenix.PubSub.subscribe(BirthdayReminder.PubSub, "money-rounds")
  end

  defp broadcast({:error, _reason} = error, _event), do: error
  defp broadcast({:ok, money_round}, event) do
    Phoenix.PubSub.broadcast(BirthdayReminder.PubSub, "money-rounds", {event, money_round})
    {:ok, money_round}
  end
end
