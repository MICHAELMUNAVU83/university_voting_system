defmodule UniversityVotingSystemWeb.VoteForPositionLive.Index do
  use UniversityVotingSystemWeb, :live_view
  alias UniversityVotingSystem.Positions
  alias UniversityVotingSystem.Users

  def mount(params, session, socket) do
    contested_positions = Positions.get_contestent_positions()
    current_user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:contested_positions, contested_positions)
     |> assign(:current_user, current_user)}
  end
end
