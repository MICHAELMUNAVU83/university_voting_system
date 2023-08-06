defmodule UniversityVotingSystemWeb.RegisterContestantLive.Index do
  use UniversityVotingSystemWeb, :live_view

  alias UniversityVotingSystem.Positions
  alias UniversityVotingSystem.Users
  alias UniversityVotingSystem.Contestants

  def mount(params, session, socket) do
    positions = Positions.list_positions()
    current_user = Users.get_user_by_session_token(session["user_token"])

    positions_user_has_contested_for =
      Contestants.get_positions_user_has_contested_for(current_user.id)

    current_user_already_contested =
      if positions_user_has_contested_for == nil do
        false
      else
        true
      end

    position_user_has_contested_for =
      if current_user_already_contested do
        positions_user_has_contested_for.position.name
      else
        ""
      end

    {:ok,
     socket
     |> assign(:positions, positions)
     |> assign(:current_user_already_contested, current_user_already_contested)
     |> assign(:position_user_has_contested_for, position_user_has_contested_for)
     |> assign(:current_user, current_user)}
  end

  def handle_event("add_a_contestant", params, socket) do
    IO.inspect(params)
    position_id = params["id"]

    positions_user_has_contested_for =
      Contestants.get_positions_user_has_contested_for(socket.assigns.current_user.id)

    current_user_already_contested =
      if positions_user_has_contested_for == nil do
        false
      else
        true
      end

    position_user_has_contested_for =
      if current_user_already_contested do
        positions_user_has_contested_for.position.name
      else
        ""
      end

    contestant_params = %{
      "user_id" => socket.assigns.current_user.id,
      "position_id" => position_id,
      "approved" => false
    }

    {ok, _contestant} = Contestants.create_contestant(contestant_params)

    {:noreply,
     socket
     |> assign(:current_user_already_contested, true)
     |> assign(:position_user_has_contested_for, position_user_has_contested_for)}
  end
end
