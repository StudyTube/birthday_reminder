defmodule BirthdayReminder.Repo.Migrations.AddUsernamesToMoneyRounds do
  use Ecto.Migration

  def change do
    alter table("money_rounds") do
      remove :user_ids, {:array, :integer}
      add :usernames, {:array, :string}, default: []
      add :identifier, :string
    end
  end
end
