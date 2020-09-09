defmodule BirthdayReminderWeb.UserController do
  use BirthdayReminderWeb, :controller

  alias BirthdayReminder.Users

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end
end
