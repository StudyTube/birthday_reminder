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
  def list_users(params) do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

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


  @doc """
  Subscribe a user.

  ## Examples

      iex> subscribe(char_id)
      {:ok, %User{}}

      iex> subscribe(chat_id)
      {:error, %Ecto.Changeset{}}

  """
  def subscribe(chat_id) do
    User
    |> Repo.get_by(chat_id: chat_id)
    |> update_user(%{subscribed: true})

    chat_id
  end

  @doc """
  Unsubscribe a user.

  ## Examples

      iex> unsubscribe(char_id)
      {:ok, %User{}}

      iex> unsubscribe(chat_id)
      {:error, %Ecto.Changeset{}}

  """
  def unsubscribe(chat_id) do
    User
    |> Repo.get_by(chat_id: chat_id)
    |> update_user(%{subscribed: false})

    chat_id
  end
end
