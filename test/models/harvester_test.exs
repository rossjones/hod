defmodule Harvest.HarvesterTest do
  use Harvest.ModelCase

  alias Harvest.Harvester

  @valid_attrs %{config: "some content", last_run: "2010-04-17 14:00:00", name: "some content", status: "some content", type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Harvester.changeset(%Harvester{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Harvester.changeset(%Harvester{}, @invalid_attrs)
    refute changeset.valid?
  end
end
