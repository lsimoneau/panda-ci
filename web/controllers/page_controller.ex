defmodule Panda.PageController do
  use Panda.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
