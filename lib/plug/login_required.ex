defmodule Harvest.Plug.LoginRequired do
  import Plug.Conn
  import Harvest.Router.Helpers
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, default) do
    current_user = get_session(conn, :current_user)
    case current_user do
        nil ->
          conn
            |> put_flash(:error, 'You need to be signed in to view this page')
            |> redirect(to: login_path(conn, :new))
        _ ->
          conn
    end
  end

end