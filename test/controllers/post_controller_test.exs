defmodule SimpleBlog.PostControllerTest do
  use SimpleBlog.ConnCase
  alias SimpleBlog.Repo
  alias SimpleBlog.User
  alias SimpleBlog.Post

  setup do
    %User{
      id: 123456,
      username: "lcp",
      email: "abc@gmail.com",
      password: Comeonin.Bcrypt.hashpwsalt("password")
    } |> Repo.insert

    {:ok, user: Repo.get(User, 123456) }
  end

  test "GET /posts/new", _context do
    conn = get conn(), "/posts/new"

    assert html_response(conn, 200) =~ "添加文章"
  end

  test "POST /posts", context do
    conn = conn()
            |> put_private(:authenticated_current_user_id, context[:user].id)
            |> post("/posts", %{ post: %{ title: "title", body: "# body" } })

    post = Repo.one(from p in Post, where: p.title == "title") |> Repo.preload(:user)

    assert get_flash(conn, :info) == "Post created successfully."
    assert post.user == context[:user]
    assert String.strip(post.body) == "<h1>body</h1>"
  end
end
