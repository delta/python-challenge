defmodule PythonChallengeWeb.SolutionsController do
  use PythonChallengeWeb, :controller
  import Ecto.Query

  alias PythonChallenge.Repo, as: Repo
  alias PythonChallenge.Solution, as: Solution

  def index(conn, %{"id" => challenge_id_string}) do
    require Logger

    if System.get_env("PHASE") === "solution" do
      case conn |> get_session(:email) do
        nil ->
          Logger.info("User is not logged in")

          conn
          |> redirect(to: conn |> Routes.auth_path(:login))

        email ->
          case Integer.parse(challenge_id_string) do
            {challenge_id, ""} when challenge_id > 0 and challenge_id <= 18 ->
              solutions =
                Repo.all(
                  from s in Solution,
                    where: s.challenge == ^challenge_id and s.solution != "",
                    order_by: [desc: s.updated_at]
                )

              user_solution =
                solutions
                |> Enum.find(
                  %{solution: nil},
                  &(&1.email == email && &1.challenge == challenge_id && &1.solution != "")
                )

              conn
              |> render("view.html",
                challenge_id: challenge_id_string,
                solutions: solutions,
                user_solution: user_solution.solution
              )

            _ ->
              conn
              |> redirect(to: conn |> Routes.solutions_path(:index))
          end
      end
    else
      conn |> redirect(to: conn |> Routes.challenge_path(:index))
    end
  end

  def index(conn, _params) do
    require Logger

    if System.get_env("PHASE") === "solution" do
      case conn |> get_session(:email) do
        nil ->
          Logger.info("User is not logged in")

          conn
          |> redirect(to: conn |> Routes.auth_path(:login))

        _ ->
          conn
          |> render("index.html")
      end
    else
      conn |> redirect(to: conn |> Routes.challenge_path(:index))
    end
  end

  def submit(conn, %{"id" => challenge_id, "solution" => user_solution}) do
    require Logger

    if System.get_env("PHASE") === "solution" do
      case conn |> get_session(:email) do
        nil ->
          Logger.info("User is not logged in")

          conn
          |> redirect(to: conn |> Routes.auth_path(:login))

        _ ->
          case Integer.parse(challenge_id) do
            {challenge_id, ""} when challenge_id > 0 and challenge_id <= 18 ->
              Repo.insert!(
                %PythonChallenge.Solution{
                  challenge: challenge_id,
                  name: conn |> get_session(:name),
                  email: conn |> get_session(:email),
                  solution: user_solution
                },
                on_conflict: [set: [solution: user_solution]],
                conflict_target: [:email, :challenge]
              )
          end

          conn
          |> redirect(to: conn |> Routes.solutions_path(:index, %{"id" => challenge_id}))
      end
    else
      conn |> redirect(to: conn |> Routes.challenge_path(:index))
    end
  end
end
