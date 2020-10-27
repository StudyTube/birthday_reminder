defmodule BirthdayReminderWeb.UserLive.Index do
  use BirthdayReminderWeb, :live_view

  alias BirthdayReminder.Users

  def mount(_params, _session, socket) do
    socket = assign(socket, users: Users.list_users())
    {:ok, socket, temporary_assigns: [users: []]}
  end
end
