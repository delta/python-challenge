defmodule PythonChallenge.Solution do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "solutions" do
    field :challenge, :integer, primary_key: true
    field :name, :string
    field :email, :string, primary_key: true
    field :solution, :string

    timestamps()
  end

  @doc false
  def changeset(solution, attrs) do
    solution
    |> cast(attrs, [:email, :name, :challenge, :solution])
    |> validate_required([:email, :name, :challenge, :solution])
  end
end
