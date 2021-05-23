defmodule BirthdayReminder.Users.Services.GetUpcomingBirthdaysTest do
  use BirthdayReminder.DataCase, async: true

  alias BirthdayReminder.Users.Services.GetUpcomingBirthdays

  test "returns a list of users with upcoming birthdays" do
    user1 = insert(:user, birthday: Timex.shift(Date.utc_today(), days: 7), subscribed: true)
    _user2 = insert(:user, birthday: Timex.shift(Date.utc_today(), days: 7), subscribed: false)
    _user3 = insert(:user, birthday: Timex.shift(Date.utc_today(), days: 10), subscribed: true)

    assert [user1] == GetUpcomingBirthdays.call()
  end
end
