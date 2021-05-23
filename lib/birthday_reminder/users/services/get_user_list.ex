defmodule BirthdayReminder.Users.Services.GetUserList do
  @moduledoc false

  import Ecto.Query, only: [order_by: 3]

  alias BirthdayReminder.Repo
  alias BirthdayReminder.Users.Schemas.User

  @doc """
  Returns list of users with ordering by month and day.

  ## Examples

    iex> GetUserList.call()
    [%User{}, ...]
  """
  @spec call :: list(User.t())
  def call do
    User
    |> order_by([u], asc: fragment("extract(month from birthday)"), asc: fragment("extract(day from birthday)"))
    |> Repo.all()
  end
end
