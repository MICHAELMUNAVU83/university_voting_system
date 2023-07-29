defmodule UniversityVotingSystem.Positions.Position do
  use Ecto.Schema
  import Ecto.Changeset

  schema "positions" do
    field :name, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(position, attrs) do
    position
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
