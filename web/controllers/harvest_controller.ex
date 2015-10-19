defmodule Harvest.HarvestController do
  use Harvest.Web, :controller

  def index(conn, _params) do
    conn
    |> render "index.html"
  end

  def new(conn, params) do
    conn
    |> render "new.html"
  end

  def edit(conn, %{"id"=>id}) do
    conn
    |> render "edit.html"
  end

  def show(conn, %{"id"=>id}) do
    conn
    |> render "show.html"
  end

end

