defmodule BirthdayReminder.MoneyRounds do
  @moduledoc """
  MoneyRounds context module.
  """
  alias BirthdayReminder.MoneyRounds.Schemas.MoneyRound

  alias BirthdayReminder.MoneyRounds.Services.{
    ConfirmPayment,
    CreateMoneyRound,
    GetCurrentRounds,
    GetPastRounds,
    UpdateMoneyRound
  }

  @doc """
  Gets list of current money rounds.

  ## Examples

    iex> current_rounds()
    [%MoneyRound{}, ...]
  """
  @spec current_rounds() :: list(MoneyRound.t())
  defdelegate current_rounds(), to: GetCurrentRounds, as: :call

  @doc """
  Gets list of past money rounds.

  ## Examples

    iex> past_rounds()
    [%MoneyRound{}, ...]
  """
  @spec past_rounds() :: list(MoneyRound.t())
  defdelegate past_rounds(), to: GetPastRounds, as: :call

  @doc """
  Creates money round.

  ## Examples

    iex> create_money_round({name: "John's birthday", expired_date: ~D[2021-05-26], identifier: "random_string"})
    {:ok, %MoneyRound{}}
  """
  @spec create_money_round(map()) :: {:ok, MoneyRound.t()} | {:error, %Ecto.Changeset{}}
  defdelegate create_money_round(params), to: CreateMoneyRound, as: :call

  @doc """
  Updates money round.

  ## Examples

    iex> update_money_round(money_round, {expired_date: ~D[2021-05-26]})
    {:ok, %MoneyRound{}}
  """
  @spec update_money_round(MoneyRound.t(), map()) :: {:ok, MoneyRound.t()} | {:error, %Ecto.Changeset{}}
  defdelegate update_money_round(money_round, params), to: UpdateMoneyRound, as: :call

  @doc """
  Confirms money round payment.

  ## Examples

    iex> confirm_payment(identifier, user)
    {:ok, %MoneyRound{}}
  """
  @spec confirm_payment(binary(), binary()) :: {:ok, MoneyRound.t()} | {:error, :money_round_not_found}
  defdelegate confirm_payment(identifier, username), to: ConfirmPayment, as: :call
end
