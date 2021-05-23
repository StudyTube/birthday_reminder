defmodule BirthdayReminder.Users do
  @moduledoc """
  Users context module.
  """

  alias BirthdayReminder.Users.Schemas.User

  alias BirthdayReminder.Users.Services.{
    GetUpcomingBirthdays,
    GetUserList,
    UpdateUser
  }

  @doc """
  Gets list of users with upcoming birthdays.

  ## Examples

    iex> upcoming_birthdays()
    [%User{}, ...]
  """
  @spec upcoming_birthdays() :: list(User.t())
  defdelegate upcoming_birthdays(), to: GetUpcomingBirthdays, as: :call

  @doc """
  Gets list of users ordered by birthday.

  ## Examples

    iex> list_users()
    [%User{}, ...]
  """
  @spec list_users() :: list(User.t())
  defdelegate list_users(), to: GetUserList, as: :call

  @doc """
  Updates user.

  ## Examples

    iex> update_user(user, %{first_name: "John", last_name: "Doe"})
    {:ok, %User{}}
  """
  @spec update_user(User.t(), map()) :: {:ok, User.t()} | {:error, %Ecto.Changeset{}}
  defdelegate update_user(user, params), to: UpdateUser, as: :call
end
