defmodule Harvest.Router do
  use Harvest.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Harvest.Plug.Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", Harvest do
    pipe_through :browser # Use the default browser stack

    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create

    get "/login", LoginController, :new
    post "/session/login", LoginController, :create
    get "/session/logout", LoginController, :delete

    get "/", PageController, :index
    get "/about", PageController, :about

    resources "/harvester", HarvesterController
    get "/harvester/:id/run", HarvesterController, :run
    get "/harvester/:id/configure", HarvesterController, :configure

  end

  # Other scopes may use custom stacks.
  # scope "/api", Harvest do
  #   pipe_through :api
  # end
end
