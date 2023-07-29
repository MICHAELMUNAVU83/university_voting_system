defmodule UniversityVotingSystem.Contestants.Contestant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contestants" do
    belongs_to :position, UniversityVotingSystem.Positions.Position
    belongs_to :user, UniversityVotingSystem.Users.User
    field :approved, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(contestant, attrs) do
    contestant
    |> cast(attrs, [:user_id, :position_id, :approved])
    |> validate_required([:user_id, :position_id, :approved])
  end
end
