defmodule UniversityVotingSystem.PositionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UniversityVotingSystem.Positions` context.
  """

  @doc """
  Generate a position.
  """
  def position_fixture(attrs \\ %{}) do
    {:ok, position} =
      attrs
      |> Enum.into(%{
        name: "some name",
        description: "some description"
      })
      |> UniversityVotingSystem.Positions.create_position()

    position
  end
end
