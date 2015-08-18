defmodule SimpleBlog.SessionController do
  use SimpleBlog.Web, :controller

  alias SimpleBlog.User

  def new(conn, _params) do
    session = User.session(%User{})

    render conn, "new.html", session: session
  end

  def create(conn, %{ "user" => session_params }) do
    session = User.session(%User{}, session_params)

    case User.verify(session) do
      {:ok, user} ->
        conn
          |> put_session(:current_user_id, user.id)
          |> put_flash(:info, "Login successfully.")
          |> redirect(to: session_path(conn, :new))
      :authorized ->
        conn
          |> put_flash(:error, "Login failed.")
          |> render("new.html", session: session)
    end
  end

  def delete(conn, _params) do
    conn
      |> put_session(:current_user_id, nil)
      |> put_flash(:info, "Logout successfully.")
      |> redirect(to: session_path(conn, :new))
  end
end
