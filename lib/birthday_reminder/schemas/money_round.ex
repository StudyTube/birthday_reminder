defmodule BirthdayReminder.MoneyRound do
  use Ecto.Schema

  import Ecto.Changeset

  schema "money_rounds" do
    field :name, :string
    field :expired_date, :date
    field :user_ids, {:array, :integer}

    timestamps()
  end

  def changeset(money_round, attrs \\ %{}) do
    money_round
    |> cast(attrs, [:name, :expired_date, :user_ids])
    |> validate_required([:name, :expired_date])
  end
end
