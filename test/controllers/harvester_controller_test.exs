defmodule Harvest.HarvesterControllerTest do
  use Harvest.ConnCase

  alias Harvest.Harvester
  @valid_attrs %{config: "some content", last_run: "2010-04-17 14:00:00", name: "some content", status: "pending", type: "CKAN"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, harvester_path(conn, :index)
    assert html_response(conn, 200) =~ "Harvesters"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, harvester_path(conn, :new)
    assert html_response(conn, 200) =~ "New harvester"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, harvester_path(conn, :create), harvester: @valid_attrs
    assert redirected_to(conn) == harvester_path(conn, :index)
    assert Repo.get_by(Harvester, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, harvester_path(conn, :create), harvester: @invalid_attrs
    assert html_response(conn, 200) =~ "New harvester"
  end

  test "shows chosen resource", %{conn: conn} do
    harvester = Repo.insert! %Harvester{}
    conn = get conn, harvester_path(conn, :show, harvester)
    assert html_response(conn, 200) =~ "Name:"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, harvester_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    harvester = Repo.insert! %Harvester{}
    conn = get conn, harvester_path(conn, :edit, harvester)
    assert html_response(conn, 200) =~ "Edit harvester"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    harvester = Repo.insert! %Harvester{}
    conn = put conn, harvester_path(conn, :update, harvester), harvester: @valid_attrs
    assert redirected_to(conn) == harvester_path(conn, :show, harvester)
    assert Repo.get_by(Harvester, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    harvester = Repo.insert! %Harvester{}
    conn = put conn, harvester_path(conn, :update, harvester), harvester: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit harvester"
  end

  test "deletes chosen resource", %{conn: conn} do
    harvester = Repo.insert! %Harvester{}
    conn = delete conn, harvester_path(conn, :delete, harvester)
    assert redirected_to(conn) == harvester_path(conn, :index)
    refute Repo.get(Harvester, harvester.id)
  end
end
