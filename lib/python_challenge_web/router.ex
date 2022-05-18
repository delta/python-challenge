defmodule PythonChallengeWeb.Router do
  use PythonChallengeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PythonChallengeWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PythonChallengeWeb do
    pipe_through :browser
    get "/", PageController, :index
  end

  scope "/auth", PythonChallengeWeb do
    pipe_through :browser
    get "/login", AuthController, :login
    get "/callback", AuthController, :callback
    get "/logout", AuthController, :logout
  end

  scope "/challenge", PythonChallengeWeb do
    pipe_through :browser
    get "/", ChallengeController, :index
    get "/wheel/:challenge/:name", ChallengeController, :wheel
    post "/submit", ChallengeController, :submit
  end

  scope "/leaderboard", PythonChallengeWeb do
    pipe_through :browser
    get "/all", LeaderboardController, :all
    get "/first-year", LeaderboardController, :first_year
  end

  scope "/solutions", PythonChallengeWeb do
    pipe_through :browser
    get "/", SolutionsController, :index
    post "/", SolutionsController, :submit
  end

  # Other scopes may use custom stacks.
  # scope "/api", PythonChallengeWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PythonChallengeWeb.Telemetry
    end
  end
end
