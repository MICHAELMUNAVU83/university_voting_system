defmodule UniversityVotingSystem.ContestantsTest do
  use UniversityVotingSystem.DataCase

  alias UniversityVotingSystem.Contestants

  describe "contestants" do
    alias UniversityVotingSystem.Contestants.Contestant

    import UniversityVotingSystem.ContestantsFixtures

    @invalid_attrs %{name: nil}

    test "list_contestants/0 returns all contestants" do
      contestant = contestant_fixture()
      assert Contestants.list_contestants() == [contestant]
    end

    test "get_contestant!/1 returns the contestant with given id" do
      contestant = contestant_fixture()
      assert Contestants.get_contestant!(contestant.id) == contestant
    end

    test "create_contestant/1 with valid data creates a contestant" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Contestant{} = contestant} = Contestants.create_contestant(valid_attrs)
      assert contestant.name == "some name"
    end

    test "create_contestant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contestants.create_contestant(@invalid_attrs)
    end

    test "update_contestant/2 with valid data updates the contestant" do
      contestant = contestant_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Contestant{} = contestant} =
               Contestants.update_contestant(contestant, update_attrs)

      assert contestant.name == "some updated name"
    end

    test "update_contestant/2 with invalid data returns error changeset" do
      contestant = contestant_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Contestants.update_contestant(contestant, @invalid_attrs)

      assert contestant == Contestants.get_contestant!(contestant.id)
    end

    test "delete_contestant/1 deletes the contestant" do
      contestant = contestant_fixture()
      assert {:ok, %Contestant{}} = Contestants.delete_contestant(contestant)
      assert_raise Ecto.NoResultsError, fn -> Contestants.get_contestant!(contestant.id) end
    end

    test "change_contestant/1 returns a contestant changeset" do
      contestant = contestant_fixture()
      assert %Ecto.Changeset{} = Contestants.change_contestant(contestant)
    end
  end
end
