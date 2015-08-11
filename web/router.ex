defmodule SimpleBlog.Router do
  use SimpleBlog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SimpleBlog do
    pipe_through :browser # Use the default browser stack

    resources "/registrations", RegistrationController, only: [:new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", SimpleBlog do
  #   pipe_through :api
  # end
end
