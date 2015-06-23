defmodule Panda.PageController do
  use Panda.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
