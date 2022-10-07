defmodule ShorterApiWeb.Router do
  use ShorterApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ShorterApiWeb.Auth.Pipeline
  end

  scope "/api", ShorterApiWeb do
    pipe_through :api

    post "/users", UsersController, :create
    post "/auth/signin", AuthController, :sign_in
  end

  scope "/api", ShorterApiWeb do
    pipe_through [:api, :auth]

    resources "/users", UsersController, only: [:show, :delete, :update]
    resources "/links", LinksController, only: [:create, :show, :delete, :update, :index]
    get "/links/:id/view", LinksController, :count_view

    get "/me", AuthController, :me
  end

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
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ShorterApiWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
