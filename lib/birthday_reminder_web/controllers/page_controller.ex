defmodule BirthdayReminderWeb.PageController do
  use BirthdayReminderWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
