defmodule Harvest.HarvesterController do
  use Harvest.Web, :controller

  alias Harvest.Harvester

  plug Harvest.Plug.LoginRequired
  plug :scrub_params, "harvester" when action in [:create, :update]

  def index(conn, _params) do
    user_id = conn.assigns.current_user.id
    harvesters = Repo.all(
          from h in Harvester,
          where: h.user_id == ^user_id,
          select: h
    )

    render(conn, "index.html", harvesters: harvesters)
  end

  def new(conn, _params) do
    changeset = Harvester.changeset(%Harvester{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"harvester" => harvester_params}) do
    uid = conn.assigns.current_user.id

    changeset = Harvester.changeset(%Harvester{:user_id=>uid}, harvester_params)

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
    uid = conn.assigns.current_user.id
    harvester = Repo.get(Harvester, id)
    if harvester == nil || harvester.user_id != uid do
      conn |> redirect(to: harvester_path(conn, :index))
    else
      render(conn, "show.html", harvester: harvester)
    end
  end

  def edit(conn, %{"id" => id}) do
    uid = conn.assigns.current_user.id
    harvester = Repo.get(Harvester, id)
    if harvester == nil || harvester.user_id != uid do
      conn |> redirect(to: harvester_path(conn, :index))
    else
      changeset = Harvester.changeset(harvester)
      render(conn, "edit.html", harvester: harvester, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "harvester" => harvester_params}) do
    uid = conn.assigns.current_user.id
    harvester = Repo.get_by(Harvester, id: id, user_id: uid)
    if harvester == nil do
      conn |> redirect(to: harvester_path(conn, :index))
    else
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
