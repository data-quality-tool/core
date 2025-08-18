defmodule CoreWeb.PageController do
  use CoreWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
