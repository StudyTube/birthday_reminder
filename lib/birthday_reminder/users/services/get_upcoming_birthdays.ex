defmodule BirthdayReminder.Users.Services.GetUpcomingBirthdays do
  @moduledoc false

  import Ecto.Query

  alias BirthdayReminder.Repo
  alias BirthdayReminder.Users.Schemas.User

  @doc """
  Returns list of users with ordering by month and day.

  ## Examples

    iex> GetUpcomingBirthdays.call()
    [%User{}, ...]
  """
  @spec call :: list(User.t())
  def call do
    query =
      from u in User,
        where:
          fragment(
            "extract(month from age(current_date + interval '7 days', ?)) = 0 and
                       extract(day from age(current_date + interval '7 days', ?)) = 0",
            u.birthday,
            u.birthday
          ) and
            u.subscribed == true

    Repo.all(query)
  end
end
