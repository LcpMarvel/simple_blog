defmodule SimpleBlog.PostControllerTest do
  use SimpleBlog.ConnCase
  alias SimpleBlog.Repo
  alias SimpleBlog.User

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
            |> post("/posts", %{ post: %{ title: "title", body: "body" } })

    assert get_flash(conn, :info) == "Post created successfully."
  end
end
