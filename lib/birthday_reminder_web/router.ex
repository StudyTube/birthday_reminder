defmodule BirthdayReminderWeb.Router do
  use BirthdayReminderWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BirthdayReminderWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BirthdayReminderWeb do
    pipe_through :browser

    resources "/", UserController, only: [:index, :edit, :update]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BirthdayReminderWeb.Telemetry
    end
  end
end
