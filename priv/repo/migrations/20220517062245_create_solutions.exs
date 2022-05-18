defmodule PythonChallenge.Repo.Migrations.CreateSolutions do
  use Ecto.Migration

  def change do
    create table(:solutions, primary_key: false) do
      add :email, :string, primary_key: true
      add :name, :string
      add :challenge, :integer, primary_key: true
      add :solution, :string

      timestamps()
    end

    create unique_index(:solutions, [:email, :challenge])
  end
end
