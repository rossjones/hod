defmodule Harvest.PageControllerTest do
  use Harvest.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Welcome to the Open Data Harvester"
  end
end
