defmodule BirthdayReminder.Users do
  import Ecto.Query, warn: false

  alias BirthdayReminder.{Repo, User}

  def list_users do
    query = from u in User,
      order_by: u.id

    Repo.all(query)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def subscribe(chat_id) do
    User
    |> Repo.get_by(chat_id: chat_id)
    |> update_user(%{subscribed: true})

    chat_id
  end

  def unsubscribe(chat_id) do
    User
    |> Repo.get_by(chat_id: chat_id)
    |> update_user(%{subscribed: false})

    chat_id
  end
end
