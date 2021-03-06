defmodule Harvest.LoginController do
  use Harvest.Web, :controller

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    conn
    |> render changeset: User.changeset(%User{})
  end

  def create(conn, %{"user" => user_params}) do
    user = if is_nil(user_params["username"]) do
      nil
    else
      Repo.get_by(User, username: user_params["username"])
    end

    user
      |> sign_in(user_params["password"], conn)
  end

  def delete(conn, _) do
    delete_session(conn, :current_user)
      |> put_flash(:info, 'You have been logged out')
      |> redirect(to: login_path(conn, :new))
  end

  defp sign_in(user, password, conn) when is_nil(user) do
    conn
      |> put_flash(:error, 'Could not find a user with that username.')
      |> render "new.html", changeset: User.changeset(%User{})
  end

  defp sign_in(user, password, conn) when is_map(user) do
    cond do
      Comeonin.Bcrypt.checkpw(password, user.encrypted_password) ->
        conn
          |> put_session(:current_user, user)
          |> redirect(to: harvester_path(conn, :index))
      true ->
        conn
          |> put_flash(:error, 'Username or password are incorrect.')
          |> render "new.html", changeset: User.changeset(%User{})
    end
  end
end