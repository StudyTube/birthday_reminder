defmodule BirthdayReminder.MoneyRound do
  use Ecto.Schema

  import Ecto.Changeset

  schema "money_rounds" do
    field :name, :string
    field :expired_date, :date
    field :usernames, {:array, :string}

    timestamps()
  end

  def changeset(money_round, attrs \\ %{}) do
    money_round
    |> cast(attrs, [:name, :expired_date, :usernames])
    |> validate_required([:name, :expired_date])
  end
end
