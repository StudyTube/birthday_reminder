defmodule BirthdayReminder.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :chat_id, :integer
      add :username, :string
      add :birthday, :date
      add :wish_note, :string
      add :subscribed, :boolean, null: false, default: false

      timestamps
    end
  end
end
