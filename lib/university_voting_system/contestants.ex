defmodule UniversityVotingSystem.Contestants do
  @moduledoc """
  The Contestants context.
  """

  import Ecto.Query, warn: false
  alias UniversityVotingSystem.Repo

  alias UniversityVotingSystem.Contestants.Contestant

  @doc """
  Returns the list of contestants.

  ## Examples

      iex> list_contestants()
      [%Contestant{}, ...]

  """
  def list_contestants do
    Repo.all(Contestant)
  end

  def get_positions_user_has_contested_for(user_id) do
    from(c in Contestant,
      where: c.user_id == ^user_id
    )
    |> Repo.one()
    |> Repo.preload(:position)
  end

  @doc """
  Gets a single contestant.

  Raises `Ecto.NoResultsError` if the Contestant does not exist.

  ## Examples

      iex> get_contestant!(123)
      %Contestant{}

      iex> get_contestant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contestant!(id), do: Repo.get!(Contestant, id)

  @doc """
  Creates a contestant.

  ## Examples

      iex> create_contestant(%{field: value})
      {:ok, %Contestant{}}

      iex> create_contestant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contestant(attrs \\ %{}) do
    %Contestant{}
    |> Contestant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contestant.

  ## Examples

      iex> update_contestant(contestant, %{field: new_value})
      {:ok, %Contestant{}}

      iex> update_contestant(contestant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contestant(%Contestant{} = contestant, attrs) do
    contestant
    |> Contestant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contestant.

  ## Examples

      iex> delete_contestant(contestant)
      {:ok, %Contestant{}}

      iex> delete_contestant(contestant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contestant(%Contestant{} = contestant) do
    Repo.delete(contestant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contestant changes.

  ## Examples

      iex> change_contestant(contestant)
      %Ecto.Changeset{data: %Contestant{}}

  """
  def change_contestant(%Contestant{} = contestant, attrs \\ %{}) do
    Contestant.changeset(contestant, attrs)
  end
end
