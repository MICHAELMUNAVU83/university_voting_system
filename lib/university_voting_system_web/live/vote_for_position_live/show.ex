defmodule UniversityVotingSystemWeb.VoteForPositionLive.Show do
  use UniversityVotingSystemWeb, :live_view
  alias UniversityVotingSystem.Positions
  alias UniversityVotingSystem.Users

  def mount(params, session, socket) do
    IO.inspect(params)

    position_id = params["id"]
    current_user = Users.get_user_by_session_token(session["user_token"])

    position = Positions.get_position!(position_id)

    {:ok,
     socket
     |> assign(:position, position)
     |> assign(:current_user, current_user)}
  end
end
