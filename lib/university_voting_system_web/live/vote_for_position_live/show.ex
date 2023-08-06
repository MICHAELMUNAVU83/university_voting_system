defmodule UniversityVotingSystemWeb.VoteForPositionLive.Show do
  use UniversityVotingSystemWeb, :live_view
  alias UniversityVotingSystem.Positions
  alias UniversityVotingSystem.Users
  alias UniversityVotingSystem.Votes

  def mount(params, session, socket) do
    IO.inspect(params)

    position_id = params["id"]
    current_user = Users.get_user_by_session_token(session["user_token"])

    position = Positions.get_position!(position_id)

    user_voted_for_this_position =
      Users.check_if_user_has_voted_for_a_position(position.id, current_user.id)

    user_vote_for_this_position =
      Votes.get_vote_for_user_and_position(current_user, position)

    {:ok,
     socket
     |> assign(:position, position)
     |> assign(:user_voted_for_this_position, user_voted_for_this_position)
     |> assign(:current_user, current_user)}
  end

  def handle_event("vote", %{"id" => id}, socket) do
    IO.inspect(id)
    IO.inspect(socket.assigns.current_user.id)
    IO.inspect(socket.assigns.position.id)

    contestant_id = String.to_integer(id)
    position_id = socket.assigns.position.id
    current_user_id = socket.assigns.current_user.id

    new_positions_voted_for =
      Map.put_new(socket.assigns.current_user.positions_voted_for, position_id, position_id)

    {_ok, vote} =
      Votes.create_vote(%{
        contestant_id: contestant_id,
        position_id: position_id,
        user_id: current_user_id
      })

    {_ok, user} =
      Users.update_user(socket.assigns.current_user, %{
        positions_voted_for: new_positions_voted_for
      })

    user_voted_for_this_position =
      Users.check_if_user_has_voted_for_a_position(position_id, current_user_id)

    IO.inspect(user)

    {:noreply,
     socket
     |> assign(:user_voted_for_this_position, user_voted_for_this_position)
     |> assign(:current_user, user)}
  end
end
