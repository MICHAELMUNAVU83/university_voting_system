defmodule UniversityVotingSystem.ContestantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UniversityVotingSystem.Contestants` context.
  """

  @doc """
  Generate a contestant.
  """
  def contestant_fixture(attrs \\ %{}) do
    {:ok, contestant} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> UniversityVotingSystem.Contestants.create_contestant()

    contestant
  end
end
