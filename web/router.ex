defmodule Tbforwarder.Router do
  use Tbforwarder.Web, :router

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

  scope "/", Tbforwarder do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", alias: Tbforwarder.Api, as: :api do
    pipe_through :api

    post "/amo/register", AmoController, :register
  end

  # Other scopes may use custom stacks.
  # scope "/api", Tbforwarder do
  #   pipe_through :api
  # end
end
