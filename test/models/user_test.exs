defmodule Harvest.UserTest do
  use Harvest.ModelCase

  alias Harvest.User

  @valid_attrs %{username: "ross"}
  @invalid_attrs %{username: ""}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
