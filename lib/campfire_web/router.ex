defmodule CampfireWeb.Router do
  use CampfireWeb, :router

  pipeline :user do
    plug(Campfire.Plugs.User)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CampfireWeb do
    pipe_through :api
  end

  scope "/" do
    pipe_through(:user)

    forward "/gql", Absinthe.Plug, schema: Campfire.Schema

    forward "/playground",
            Absinthe.Plug.GraphiQL,
            schema: Campfire.Schema,
            interface: :playground
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
      live_dashboard "/dashboard", metrics: CampfireWeb.Telemetry
    end
  end
end
