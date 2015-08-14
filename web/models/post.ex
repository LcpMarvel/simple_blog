defmodule SimpleBlog.Post do
  use SimpleBlog.Web, :model

  alias SimpleBlog.Post

  schema "posts" do
    belongs_to :user, SimpleBlog.User
    field :title, :string
    field :body, :string

    timestamps
  end

  def changeset(post, params \\ :empty) do
    post
      |> cast(params, ~w{user_id title body}, ~w{})
  end
end
