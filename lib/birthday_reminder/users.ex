defmodule BirthdayReminder.Users do
  import Ecto.Query, warn: false

  alias BirthdayReminder.{Repo, User}

  def list_users do
    query = from u in User,
      order_by: [asc: fragment("extract(month from birthday)"), asc: fragment("extract(day from birthday)")]

    Repo.all(query)
  end

  def subscribed_users(except_users) do
    except_ids = Enum.map(except_users, &(&1).id)

    query = from u in User,
      where: u.subscribed == true and not(u.id in ^except_ids)

    Repo.all(query)
  end

  def closest_birthdays do
    query = from u in User,
      where: fragment("extract(month from age(current_date + interval '7 days', ?)) = 0 and
                       extract(day from age(current_date + interval '7 days', ?)) = 0",
                       u.birthday,
                       u.birthday) and
             u.subscribed == true

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

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
