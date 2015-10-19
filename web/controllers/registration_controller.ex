defmodule Harvest.RegistrationController do
  use Harvest.Web, :controller
  alias Harvest.Password

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    conn
    |> render changeset: changeset
  end


 def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    if changeset.valid? do
      case Password.generate_password_and_store_user(changeset) do
        {:error, changeset} ->
          render conn, "new.html", changeset: changeset
        {:ok, changeset } ->
          conn
            |> put_flash(:info, "Successfully registered, please log in")
            |> redirect(to: login_path(conn, :new))
      end

    else
      render conn, "new.html", changeset: changeset
    end
  end

end