defmodule BirthdayReminder.Users.Services.GetUserListTest do
  use BirthdayReminder.DataCase, async: true

  alias BirthdayReminder.Users.Services.GetUserList

  test "returns a list of users in the correct order" do
    user1 = insert(:user, birthday: ~D[1985-05-06])
    user2 = insert(:user, birthday: ~D[1994-10-10])
    user3 = insert(:user, birthday: ~D[1990-01-03])

    assert [user3, user1, user2] == GetUserList.call()
  end
end
