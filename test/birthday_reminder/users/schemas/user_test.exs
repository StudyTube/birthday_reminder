defmodule BirthdayReminder.Users.Schemas.UserTest do
  use BirthdayReminder.DataCase, async: true

  alias BirthdayReminder.Users.Schemas.User

  setup do
    base_params = %{
      first_name: "John",
      last_name: "Doe",
      birthday: ~D[2000-01-01]
    }

    [base_params: base_params]
  end

  describe "changeset/2" do
    test "returns valid changeset", %{base_params: base_params} do
      changeset = User.changeset(%User{}, base_params)

      assert errors_on(changeset) == %{}
    end

    test "returns invalid chaangeset, when first_name isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{first_name: nil})
      changeset = User.changeset(%User{}, invalid_params)

      assert errors_on(changeset) == %{first_name: ["can't be blank"]}
    end

    test "returns invalid chaangeset, when last_name isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{last_name: nil})
      changeset = User.changeset(%User{}, invalid_params)

      assert errors_on(changeset) == %{last_name: ["can't be blank"]}
    end

    test "returns invalid chaangeset, when birthday isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{birthday: nil})
      changeset = User.changeset(%User{}, invalid_params)

      assert errors_on(changeset) == %{birthday: ["can't be blank"]}
    end
  end
end
