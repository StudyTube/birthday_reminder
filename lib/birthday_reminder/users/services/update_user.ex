defmodule BirthdayReminder.Users.Services.UpdateUser do
  @moduledoc false

  alias BirthdayReminder.Users.Schemas.User
  alias BirthdayReminder.Repo

  @doc """
  Returns updated user by passed params.

  ## Examples

    iex> UpdateUser.call(user, %{first_name: "John"})
    {:ok, %User{}}

    iex> UpdateUser.call(user, %{first_name: ""})
    {:error, %Ecto.Changeset{}}
  """
  @spec call(User.t(), map()) :: {:ok, User.t()} | {:error, %Ecto.Changeset{}}
  def call(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
