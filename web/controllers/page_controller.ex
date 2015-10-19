defmodule Harvest.PageController do
  use Harvest.Web, :controller

  def index(conn, _params) do
    conn
    |> render "index.html"
  end

  def about(conn, _) do
    conn
    |> render "about.html"
  end

end
