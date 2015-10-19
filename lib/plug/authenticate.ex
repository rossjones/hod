defmodule Harvest.Plug.Authenticate do
  import Plug.Conn
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, default) do
    current_user = get_session(conn, :current_user)
    if current_user do
      conn
      |> assign( :current_user, current_user)
    else
      conn
      |> assign( :current_user, false)
    end
  end
end