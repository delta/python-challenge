defmodule PythonChallenge.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :is_first_year, :boolean, default: false, null: false
      add :challenges_completed, :integer

      timestamps()
    end
  end
end
