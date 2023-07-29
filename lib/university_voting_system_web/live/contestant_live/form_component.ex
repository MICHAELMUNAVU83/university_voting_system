defmodule UniversityVotingSystemWeb.ContestantLive.FormComponent do
  use UniversityVotingSystemWeb, :live_component

  alias UniversityVotingSystem.Contestants

  @impl true
  def update(%{contestant: contestant} = assigns, socket) do
    changeset = Contestants.change_contestant(contestant)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"contestant" => contestant_params}, socket) do
    changeset =
      socket.assigns.contestant
      |> Contestants.change_contestant(contestant_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"contestant" => contestant_params}, socket) do
    save_contestant(socket, socket.assigns.action, contestant_params)
  end

  defp save_contestant(socket, :edit, contestant_params) do
    case Contestants.update_contestant(socket.assigns.contestant, contestant_params) do
      {:ok, _contestant} ->
        {:noreply,
         socket
         |> put_flash(:info, "Contestant updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_contestant(socket, :new, contestant_params) do
    case Contestants.create_contestant(contestant_params) do
      {:ok, _contestant} ->
        {:noreply,
         socket
         |> put_flash(:info, "Contestant created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
