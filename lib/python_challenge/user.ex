defmodule PythonChallenge.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :challenges_completed, :integer
    field :is_first_year, :boolean, default: false
    field :name, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :is_first_year, :challenges_completed])
    |> validate_required([:name, :email, :is_first_year, :challenges_completed])
  end
end
