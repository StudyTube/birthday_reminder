defmodule BirthdayReminderWeb.Router do
  use BirthdayReminderWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BirthdayReminderWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug(BirthdayReminder.AdminPlug)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BirthdayReminderWeb do
    pipe_through :browser

    resources "/", UserController, only: [:index, :edit, :update]
    live "/money-round", MoneyRound
  end

  scope "/" do
    pipe_through [:browser, :admin]
    live_dashboard "/dashboard", metrics: BirthdayReminderWeb.Telemetry
  end
end
