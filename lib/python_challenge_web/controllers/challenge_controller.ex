defmodule PythonChallengeWeb.ChallengeController do
  use PythonChallengeWeb, :controller

  alias PythonChallenge.Repo, as: Repo
  alias PythonChallenge.User, as: User

  def index(conn, _params) do
    require Logger

    case conn |> get_session(:email) do
      nil ->
        Logger.info("User is not logged in")
        conn
        |> redirect(to: conn |> Routes.auth_path(:login))
      email ->
        challenges_completed = Repo.get_by(User, email: email).challenges_completed
        Logger.info("User: #{email} #{challenges_completed} challenges completed")

        case challenges_completed do
          18 ->
            conn
            |> render("completed.html")
          _ ->
            conn
            |> render("index.html", challenge_id: "#{challenges_completed + 1}")
        end
    end
  end

  def wheel(conn, %{"name" => name, "challenge" => challenge}) do
    require Logger
    case conn |> get_session(:email) do
      nil ->
        Logger.info("User is not logged in")
        conn
        |> redirect(to: conn |> Routes.auth_path(:login))
      email ->
        if System.get_env("PHASE") === "solution" do
          conn
          |> send_download({:file, "wheels/#{challenge}/#{name}"})
        else
          challenges_completed = Repo.get_by(User, email: email).challenges_completed
          Logger.info("User: #{email} #{challenges_completed} challenges completed")

          case challenges_completed do
            18 ->
              conn
              |> halt()
            _ ->
              conn
              |> send_download({:file, "wheels/#{challenges_completed + 1}/#{name}"})
          end
        end
    end
  end

  def submit(conn, %{"solution" => user_solution}) do
    require Logger

    case conn |> get_session(:email) do
      nil ->
        Logger.info("User is not logged in")
        conn
        |> redirect(to: conn |> Routes.auth_path(:login))
      email ->
        challenges_completed = Repo.get_by(User, email: email).challenges_completed
        case challenges_completed do
          18 ->
            conn
            |> render("completed.html")
          _ ->
            solution = System.get_env("CHALL_#{challenges_completed + 1}_SOLN")
            if solution === user_solution do
              Logger.info("User #{email} submitted correct solution to chall #{challenges_completed + 1}")

              if System.get_env("PHASE") === "challenge" do
                Repo.get_by(User, email: email)
                |> Ecto.Changeset.change(%{challenges_completed: challenges_completed + 1})
                |> Repo.update()
              end

              conn
              |> redirect(to: conn |> Routes.challenge_path(:index, solution: "correct"))
            else
              Logger.info("User #{email} submitted wrong solution to chall #{challenges_completed + 1}")

              conn
              |> redirect(to: conn |> Routes.challenge_path(:index, solution: "incorrect"))
            end
        end
    end
  end
end
