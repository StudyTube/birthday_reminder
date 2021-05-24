defmodule BirthdayReminder.UserFactory do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %BirthdayReminder.Users.Schemas.User{
          first_name: sequence(:name, &"First_#{&1}"),
          last_name: sequence(:email, &"Last#{&1}"),
          birthday: ~D[2000-01-03]
        }
      end
    end
  end
end
