defmodule PythonChallenge.Repo.Migrations.UpdateSolutions do
  use Ecto.Migration

  def change do
    alter table(:solutions) do
      modify :solution, :text
    end
  end
end
