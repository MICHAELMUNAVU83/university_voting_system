defmodule UniversityVotingSystem.PositionsTest do
  use UniversityVotingSystem.DataCase

  alias UniversityVotingSystem.Positions

  describe "positions" do
    alias UniversityVotingSystem.Positions.Position

    import UniversityVotingSystem.PositionsFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_positions/0 returns all positions" do
      position = position_fixture()
      assert Positions.list_positions() == [position]
    end

    test "get_position!/1 returns the position with given id" do
      position = position_fixture()
      assert Positions.get_position!(position.id) == position
    end

    test "create_position/1 with valid data creates a position" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %Position{} = position} = Positions.create_position(valid_attrs)
      assert position.name == "some name"
      assert position.description == "some description"
    end

    test "create_position/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Positions.create_position(@invalid_attrs)
    end

    test "update_position/2 with valid data updates the position" do
      position = position_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %Position{} = position} = Positions.update_position(position, update_attrs)
      assert position.name == "some updated name"
      assert position.description == "some updated description"
    end

    test "update_position/2 with invalid data returns error changeset" do
      position = position_fixture()
      assert {:error, %Ecto.Changeset{}} = Positions.update_position(position, @invalid_attrs)
      assert position == Positions.get_position!(position.id)
    end

    test "delete_position/1 deletes the position" do
      position = position_fixture()
      assert {:ok, %Position{}} = Positions.delete_position(position)
      assert_raise Ecto.NoResultsError, fn -> Positions.get_position!(position.id) end
    end

    test "change_position/1 returns a position changeset" do
      position = position_fixture()
      assert %Ecto.Changeset{} = Positions.change_position(position)
    end
  end
end
