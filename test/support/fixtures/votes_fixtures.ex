defmodule UniversityVotingSystem.VotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UniversityVotingSystem.Votes` context.
  """

  @doc """
  Generate a vote.
  """
  def vote_fixture(attrs \\ %{}) do
    {:ok, vote} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> UniversityVotingSystem.Votes.create_vote()

    vote
  end
end
