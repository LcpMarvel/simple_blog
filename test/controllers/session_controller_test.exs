defmodule SimpleBlog.SessionControllerTest do
  use SimpleBlog.ConnCase
  alias SimpleBlog.Repo

  test "GET /session/new" do
    conn = get conn(), "/session/new"

    assert html_response(conn, 200) =~ "登录"
  end

  setup do
    %SimpleBlog.User{
      id: 123456,
      username: "lcp",
      email: "abc@gmail.com",
      password: Comeonin.Bcrypt.hashpwsalt("password")
    } |> Repo.insert

    :ok
  end

  test "POST /session successfully" do
    params = %{
      user: %{
        email: "abc@gmail.com",
        password: "password"
      }
    }
    conn = post conn(), "/session", params

    assert get_session(conn, :user_id) == 123456
  end

  test "POST /session failed" do
    params = %{
      user: %{
        email: "abc@gmail.com",
        password: "invalid"
      }
    }
    conn = post conn(), "/session", params

    assert get_flash(conn, :error) == "Login failed."
  end

  test "DELETE /session" do
    conn = delete conn(), "/session"

    assert !get_session(conn, :user_id)
    assert get_flash(conn, :info) == "Logout successfully."
  end
end
