defmodule BirthdayReminder.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :chat_id, :integer
    field :username, :string
    field :birthday, :date
    field :wish_note, :string
    field :subscribed, :boolean, default: false

    timestamps()
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:first_name, :last_name, :chat_id, :username, :birthday, :subscribed])
    |> validate_required([:first_name, :last_name, :birthday, :subscribed])
  end
end
