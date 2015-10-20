defmodule Harvest.HarvesterView do
  use Harvest.Web, :view

  def level_for_state("pending"), do: "info"
  def level_for_state("running"), do: "warning"
  def level_for_state("failed"), do: "danger"
  def level_for_state(_), do: "info"

end
