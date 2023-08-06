defmodule UniversityVotingSystemWeb.VoteForPositionLive.Index do
  use UniversityVotingSystemWeb, :live_view
  alias UniversityVotingSystem.Positions

  def mount(params, session, socket) do
    contested_positions = Positions.get_contestent_positions()

    {:ok, socket |> assign(:contested_positions, contested_positions)}
  end
end
