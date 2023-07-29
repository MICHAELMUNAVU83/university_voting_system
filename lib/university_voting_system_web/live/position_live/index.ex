defmodule UniversityVotingSystemWeb.PositionLive.Index do
  use UniversityVotingSystemWeb, :live_view

  alias UniversityVotingSystem.Positions
  alias UniversityVotingSystem.Positions.Position

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :positions, list_positions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Position")
    |> assign(:position, Positions.get_position!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Position")
    |> assign(:position, %Position{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Positions")
    |> assign(:position, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    position = Positions.get_position!(id)
    {:ok, _} = Positions.delete_position(position)

    {:noreply, assign(socket, :positions, list_positions())}
  end

  defp list_positions do
    Positions.list_positions()
  end
end
