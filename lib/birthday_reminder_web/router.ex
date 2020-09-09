defmodule BirthdayReminderWeb.Router do
  use BirthdayReminderWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BirthdayReminderWeb do
    pipe_through :browser

    get "/", UserController, :index
  end
end
