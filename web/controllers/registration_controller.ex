defmodule SimpleBlog.RegistrationController do
  use SimpleBlog.Web, :controller

  alias SimpleBlog.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset %User{}, user_params

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
          |> put_flash(:info, "User created successfully.")
          |> redirect(to: registration_path(conn, :new))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
