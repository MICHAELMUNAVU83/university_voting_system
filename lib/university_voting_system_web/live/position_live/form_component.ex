defmodule UniversityVotingSystemWeb.PositionLive.FormComponent do
  use UniversityVotingSystemWeb, :live_component

  alias UniversityVotingSystem.Positions

  @impl true
  def update(%{position: position} = assigns, socket) do
    changeset = Positions.change_position(position)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"position" => position_params}, socket) do
    changeset =
      socket.assigns.position
      |> Positions.change_position(position_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"position" => position_params}, socket) do
    save_position(socket, socket.assigns.action, position_params)
  end

  defp save_position(socket, :edit, position_params) do
    case Positions.update_position(socket.assigns.position, position_params) do
      {:ok, _position} ->
        {:noreply,
         socket
         |> put_flash(:info, "Position updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_position(socket, :new, position_params) do
    case Positions.create_position(position_params) do
      {:ok, _position} ->
        {:noreply,
         socket
         |> put_flash(:info, "Position created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
