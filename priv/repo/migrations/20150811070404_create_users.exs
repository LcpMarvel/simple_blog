defmodule SimpleBlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, size: 30
      add :email, :string
      add :password, :string

      timestamps
    end
  end
end
