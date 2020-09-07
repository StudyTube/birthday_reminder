defmodule BirthdayReminder.Users do
  @moduledoc """
  The User context.
  """

  import Ecto.Query, warn: false
  alias BirthdayReminder.{Repo, User}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_movies(params) do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %Movie{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movie!(id), do: Repo.get!(User, id)

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
