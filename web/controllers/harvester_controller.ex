defmodule Harvest.HarvesterController do
  use Harvest.Web, :controller

  alias Harvest.Harvester

  plug :scrub_params, "harvester" when action in [:create, :update]

  def index(conn, _params) do
    harvester = Repo.all(Harvester)
    render(conn, "index.html", harvester: harvester)
  end

  def new(conn, _params) do
    changeset = Harvester.changeset(%Harvester{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"harvester" => harvester_params}) do
    changeset = Harvester.changeset(%Harvester{}, harvester_params)

    case Repo.insert(changeset) do
      {:ok, _harvester} ->
        conn
        |> put_flash(:info, "Harvester created successfully.")
        |> redirect(to: harvester_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    harvester = Repo.get!(Harvester, id)
    render(conn, "show.html", harvester: harvester)
  end

  def edit(conn, %{"id" => id}) do
    harvester = Repo.get!(Harvester, id)
    changeset = Harvester.changeset(harvester)
    render(conn, "edit.html", harvester: harvester, changeset: changeset)
  end

  def update(conn, %{"id" => id, "harvester" => harvester_params}) do
    harvester = Repo.get!(Harvester, id)
    changeset = Harvester.changeset(harvester, harvester_params)

    case Repo.update(changeset) do
      {:ok, harvester} ->
        conn
        |> put_flash(:info, "Harvester updated successfully.")
        |> redirect(to: harvester_path(conn, :show, harvester))
      {:error, changeset} ->
        render(conn, "edit.html", harvester: harvester, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    harvester = Repo.get!(Harvester, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(harvester)

    conn
    |> put_flash(:info, "Harvester deleted successfully.")
    |> redirect(to: harvester_path(conn, :index))
  end
end
