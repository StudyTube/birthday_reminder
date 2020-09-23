defmodule BirthdayReminderWeb.UserController do
  use BirthdayReminderWeb, :controller

  alias BirthdayReminder.{Users, Repo}

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)

    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => params}) do
    id
    |> Users.get_user!
    |> Users.change_user(params)
    |> Repo.update

    redirect(conn, to: Routes.user_path(conn, :index))
  end
end
