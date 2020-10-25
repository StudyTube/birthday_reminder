defmodule BirthdayReminderWeb.LayoutView do
  use BirthdayReminderWeb, :view

  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    if path == current_path, do: "active", else: "regular"
  end
end
