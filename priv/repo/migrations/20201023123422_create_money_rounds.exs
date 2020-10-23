defmodule BirthdayReminder.Repo.Migrations.CreateMoneyRounds do
  use Ecto.Migration

  def change do
    create table(:money_rounds) do
      add :name, :string
      add :expired_date, :date
      add :user_ids, {:array, :integer}

      timestamps()
    end
  end
end
