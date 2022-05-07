defmodule PythonChallengeWeb.LeaderboardController do
  use PythonChallengeWeb, :controller
  import Ecto.Query

  alias PythonChallenge.Repo, as: Repo
  alias PythonChallenge.User, as: User

  def all(conn, _params) do
    conn
    |> render(
      "all.html",
      users: Repo.all(from u in User, order_by: [desc: u.challenges_completed]),
      current_user: conn |> get_session(:email)
    )
  end

  def first_year(conn, _params) do
    conn
    |> render(
      "first_year.html",
      users: Repo.all(from u in User, where: u.is_first_year, order_by: [desc: u.challenges_completed]),
      current_user: conn |> get_session(:email)
    )
  end
end
