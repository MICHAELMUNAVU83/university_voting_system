defmodule UniversityVotingSystemWeb.ContestantLive.Index do
  use UniversityVotingSystemWeb, :live_view

  alias UniversityVotingSystem.Contestants
  alias UniversityVotingSystem.Contestants.Contestant

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :contestants, list_contestants())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Contestant")
    |> assign(:contestant, Contestants.get_contestant!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Contestant")
    |> assign(:contestant, %Contestant{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Contestants")
    |> assign(:contestant, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    contestant = Contestants.get_contestant!(id)
    {:ok, _} = Contestants.delete_contestant(contestant)

    {:noreply, assign(socket, :contestants, list_contestants())}
  end

  defp list_contestants do
    Contestants.list_contestants()
  end
end
