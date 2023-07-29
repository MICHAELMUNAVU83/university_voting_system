defmodule UniversityVotingSystem.Votes.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    belongs_to :contestant, UniversityVotingSystem.Contestants.Contestant
    belongs_to :position, UniversityVotingSystem.Positions.Position
    belongs_to :user, UniversityVotingSystem.Users.User

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:user_id, :contestant_id, :position_id])
    |> validate_required([:user_id, :contestant_id, :position_id])
  end
end
