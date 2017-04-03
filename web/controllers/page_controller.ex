defmodule CompaShares.PageController do
  use CompaShares.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
