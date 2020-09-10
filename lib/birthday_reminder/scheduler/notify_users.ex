defmodule BirthdayReminder.NotifyUsers do
  import Ecto.Query, warn: false

  alias BirthdayReminder.Users

  def run do
    case Users.closest_birthdays do

      [] -> nil
    end


    Users.subscribed_users

  end
end
