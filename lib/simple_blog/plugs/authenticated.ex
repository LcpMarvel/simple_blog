defmodule SimpleBlog.Plugs.Authenticated do
  import Plug.Conn
  alias Phoenix.Controller
  alias SimpleBlog.Router.Helpers
  alias SimpleBlog.User

  def init(options) do
    options
  end

  def call(conn, _) do
    case conn |> current_user_id do
      nil ->
        conn
          |> Controller.put_flash(:error, "You must be logged in")
          |> Controller.redirect(to: Helpers.session_path(conn, :new))
          |> halt
      current_user_id ->
        conn |> assign(:current_user, SimpleBlog.Repo.get(User, current_user_id))
    end
  end

  defp current_user_id(conn) do
    case Mix.env do
      :test ->
        conn.private[:authenticated_current_user_id]
      _ ->
        conn |> fetch_session |> get_session(:current_user_id)
    end
  end
end
