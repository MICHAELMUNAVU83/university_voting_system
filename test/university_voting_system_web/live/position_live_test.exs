defmodule UniversityVotingSystemWeb.PositionLiveTest do
  use UniversityVotingSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import UniversityVotingSystem.PositionsFixtures

  @create_attrs %{name: "some name", description: "some description"}
  @update_attrs %{name: "some updated name", description: "some updated description"}
  @invalid_attrs %{name: nil, description: nil}

  defp create_position(_) do
    position = position_fixture()
    %{position: position}
  end

  describe "Index" do
    setup [:create_position]

    test "lists all positions", %{conn: conn, position: position} do
      {:ok, _index_live, html} = live(conn, Routes.position_index_path(conn, :index))

      assert html =~ "Listing Positions"
      assert html =~ position.name
    end

    test "saves new position", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.position_index_path(conn, :index))

      assert index_live |> element("a", "New Position") |> render_click() =~
               "New Position"

      assert_patch(index_live, Routes.position_index_path(conn, :new))

      assert index_live
             |> form("#position-form", position: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#position-form", position: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.position_index_path(conn, :index))

      assert html =~ "Position created successfully"
      assert html =~ "some name"
    end

    test "updates position in listing", %{conn: conn, position: position} do
      {:ok, index_live, _html} = live(conn, Routes.position_index_path(conn, :index))

      assert index_live |> element("#position-#{position.id} a", "Edit") |> render_click() =~
               "Edit Position"

      assert_patch(index_live, Routes.position_index_path(conn, :edit, position))

      assert index_live
             |> form("#position-form", position: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#position-form", position: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.position_index_path(conn, :index))

      assert html =~ "Position updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes position in listing", %{conn: conn, position: position} do
      {:ok, index_live, _html} = live(conn, Routes.position_index_path(conn, :index))

      assert index_live |> element("#position-#{position.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#position-#{position.id}")
    end
  end

  describe "Show" do
    setup [:create_position]

    test "displays position", %{conn: conn, position: position} do
      {:ok, _show_live, html} = live(conn, Routes.position_show_path(conn, :show, position))

      assert html =~ "Show Position"
      assert html =~ position.name
    end

    test "updates position within modal", %{conn: conn, position: position} do
      {:ok, show_live, _html} = live(conn, Routes.position_show_path(conn, :show, position))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Position"

      assert_patch(show_live, Routes.position_show_path(conn, :edit, position))

      assert show_live
             |> form("#position-form", position: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#position-form", position: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.position_show_path(conn, :show, position))

      assert html =~ "Position updated successfully"
      assert html =~ "some updated name"
    end
  end
end
