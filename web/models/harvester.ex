defmodule Harvest.Harvester do
  use Harvest.Web, :model

  schema "harvester" do
    field :name, :string
    field :type, :string
    field :status, :string
    field :config, :string
    field :last_run, Ecto.DateTime
    belongs_to :user, Harvest.User

    timestamps
  end

  @required_fields ~w(name type status config last_run)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
