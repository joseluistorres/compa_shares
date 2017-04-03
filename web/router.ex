defmodule CompaShares.Router do
  use CompaShares.Web, :router

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

  scope "/", CompaShares do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/shares", ShareController
    get "/shares/:id/description", ShareController, :update_description
  end

  # Other scopes may use custom stacks.
  # scope "/api", CompaShares do
  #   pipe_through :api
  # end
end
