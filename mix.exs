defmodule BirthdayReminder.MixProject do
  use Mix.Project

  def project do
    [
      app: :birthday_reminder,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      preferred_cli_env: [ci: :test]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {BirthdayReminder.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "test/factories"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # phoenix
      {:phoenix, "~> 1.5.7"},
      {:phoenix_ecto, "~> 4.1"},
      {:ecto_sql, "~> 3.4"},
      {:phoenix_live_view, "~> 0.15.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},

      # live dashboard and telemetry
      {:phoenix_live_dashboard, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},

      # internationalization and localization
      {:gettext, "~> 0.11"},

      # JSON parser
      {:jason, "~> 1.0"},

      # adapter to cowboy web server
      {:plug_cowboy, "~> 2.0"},

      # date/time library
      {:timex, "~> 3.6"},

      # database adapter
      {:postgrex, ">= 0.0.0"},

      # Telegram Bot API Wrapper
      {:nadia, "~> 0.7.0"},

      # Cron-like job scheduler
      {:quantum, "~> 3.0"},

      # Static code analyzer
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},

      # create test data
      {:ex_machina, "~> 2.5.0", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "phx.start": ["ecto.create --quiet", "ecto.migrate", "phx.server"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"],
      ci: ["format --check-formatted", "credo --strict", "test"]
    ]
  end
end
