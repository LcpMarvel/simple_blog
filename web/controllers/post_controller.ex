defmodule SimpleBlog.PostController do
  use SimpleBlog.Web, :controller
  alias SimpleBlog.Post

  plug SimpleBlog.Plugs.Authenticated

  def index(conn, _params) do
    posts = Repo.all(from p in Post, preload: [:user])

    render conn, "index.html", posts: posts
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{ "post" => post_params }) do
    changeset = Post.changeset(%Post{user_id: conn.assigns[:current_user].id}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
          |> put_flash(:info, "Post created successfully.")
          |> redirect(to: post_path(conn, :new))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
