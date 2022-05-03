defmodule PythonChallengeWeb.PageController do
  use PythonChallengeWeb, :controller

  def index(conn, _params) do
    conn |> render("index.html", name: conn |> get_session(:name))
  end
end
