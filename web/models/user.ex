defmodule SimpleBlog.User do
  use SimpleBlog.Web, :model
  alias SimpleBlog.User
  alias SimpleBlog.Repo
  alias Comeonin.Bcrypt

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string

    timestamps
  end

  def changeset(user, params \\ :empty) do
    user_changeset =
      user
        |> cast(params, ~w(username email password), ~w())
        |> validate_confirmation(:password, message: "passwords do not match")
        |> validate_length(:password, min: 6, message: "length of password must greater than 6")
        |> validate_unique(:email, on: Repo, downcase: true, message: "email must be unique")
        |> validate_unique(:username, on: Repo, downcase: true, message: "username must be unique")
        |> validate_format(:email, ~r/@/)

    user_changeset
      |> put_change(:password, encrypt(user_changeset))
      |> delete_change(:password_confirmation)
  end

  def encrypt(changeset) do
    changeset |> get_field(:password) |> to_string |> Bcrypt.hashpwsalt
  end
end
