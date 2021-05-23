defmodule BirthdayReminder.Users.Services.UpdateUserTest do
  use BirthdayReminder.DataCase, async: true

  alias BirthdayReminder.Users.Services.UpdateUser

  describe "with valid params" do
    test "returns update user" do
      user = insert(:user)

      assert {:ok, updated_user} = UpdateUser.call(user, %{first_name: "John"})
      assert user.first_name != updated_user.first_name
    end
  end

  describe "with invalid params" do
    test "returns error" do
      user = insert(:user)

      assert {:error, %Ecto.Changeset{}} = UpdateUser.call(user, %{first_name: ""})
    end
  end
end
