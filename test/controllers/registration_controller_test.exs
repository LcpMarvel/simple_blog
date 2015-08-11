defmodule SimpleBlog.RegistrationControllerTest do
  use SimpleBlog.ConnCase

  test "GET /registrations/new" do
    conn = get conn(), "/registrations/new"

    assert html_response(conn, 200) =~ "注册"
  end

  test "POST /registrations" do
    params = %{
      user: %{
        email: "lcp@gmail.com",
        username: "lcp",
        password: "password",
        password_confirmation: "password"
      }
    }
    conn = post conn(), "/registrations", params

    assert get_flash(conn, :info) == "User created successfully."
  end
end
