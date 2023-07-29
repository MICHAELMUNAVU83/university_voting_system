defmodule UniversityVotingSystemWeb.ContestantLiveTest do
  use UniversityVotingSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import UniversityVotingSystem.ContestantsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_contestant(_) do
    contestant = contestant_fixture()
    %{contestant: contestant}
  end

  describe "Index" do
    setup [:create_contestant]

    test "lists all contestants", %{conn: conn, contestant: contestant} do
      {:ok, _index_live, html} = live(conn, Routes.contestant_index_path(conn, :index))

      assert html =~ "Listing Contestants"
      assert html =~ contestant.name
    end

    test "saves new contestant", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.contestant_index_path(conn, :index))

      assert index_live |> element("a", "New Contestant") |> render_click() =~
               "New Contestant"

      assert_patch(index_live, Routes.contestant_index_path(conn, :new))

      assert index_live
             |> form("#contestant-form", contestant: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#contestant-form", contestant: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.contestant_index_path(conn, :index))

      assert html =~ "Contestant created successfully"
      assert html =~ "some name"
    end

    test "updates contestant in listing", %{conn: conn, contestant: contestant} do
      {:ok, index_live, _html} = live(conn, Routes.contestant_index_path(conn, :index))

      assert index_live |> element("#contestant-#{contestant.id} a", "Edit") |> render_click() =~
               "Edit Contestant"

      assert_patch(index_live, Routes.contestant_index_path(conn, :edit, contestant))

      assert index_live
             |> form("#contestant-form", contestant: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#contestant-form", contestant: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.contestant_index_path(conn, :index))

      assert html =~ "Contestant updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes contestant in listing", %{conn: conn, contestant: contestant} do
      {:ok, index_live, _html} = live(conn, Routes.contestant_index_path(conn, :index))

      assert index_live |> element("#contestant-#{contestant.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#contestant-#{contestant.id}")
    end
  end

  describe "Show" do
    setup [:create_contestant]

    test "displays contestant", %{conn: conn, contestant: contestant} do
      {:ok, _show_live, html} = live(conn, Routes.contestant_show_path(conn, :show, contestant))

      assert html =~ "Show Contestant"
      assert html =~ contestant.name
    end

    test "updates contestant within modal", %{conn: conn, contestant: contestant} do
      {:ok, show_live, _html} = live(conn, Routes.contestant_show_path(conn, :show, contestant))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Contestant"

      assert_patch(show_live, Routes.contestant_show_path(conn, :edit, contestant))

      assert show_live
             |> form("#contestant-form", contestant: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#contestant-form", contestant: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.contestant_show_path(conn, :show, contestant))

      assert html =~ "Contestant updated successfully"
      assert html =~ "some updated name"
    end
  end
end
