defmodule PythonChallengeWeb.AuthController do
  use PythonChallengeWeb, :controller

  def login(conn, _params) do
    require Logger

    case conn |> get_session(:email) do
      nil ->
        url = DAuth.authorize_url!()

        conn
        |> redirect(external: url)

      email ->
        Logger.info("User logged in: #{email}")

        conn
        |> redirect(to: conn |> Routes.page_path(:index))
    end
  end

  def callback(conn, %{"code" => code}) do
    require Logger
    alias PythonChallenge.Repo, as: Repo

    case conn |> get_session(:email) do
      nil ->
        client = DAuth.get_token!(code: code)

        case OAuth2.Client.post(client, "/api/resources/user") do
          {:ok, %OAuth2.Response{body: %{"email" => email, "name" => name}}} ->
            if Repo.get_by(PythonChallenge.User, email: email) == nil do
              Logger.info("Inserting user into DB: #{email}")
              year = String.slice(email, 4..5)

              Repo.insert(%PythonChallenge.User{
                email: email,
                name: name,
                challenges_completed: 0,
                is_first_year: year == "21"
              })
            end

            Logger.info("User: #{email} #{name} logged in")

            conn
            |> put_session(:email, email)
            |> put_session(:name, name)
            |> configure_session(renew: true)
            |> redirect(to: conn |> Routes.page_path(:index))

          {:error, %OAuth2.Response{status_code: code}} ->
            Logger.error("OAuth2 request failed with code: #{code}")

            conn
            |> redirect(to: conn |> Routes.page_path(:index))

          {:error, %OAuth2.Error{reason: reason}} ->
            Logger.error("Error: #{reason}")

            conn
            |> redirect(to: conn |> Routes.page_path(:index))
        end

      email ->
        Logger.info("User #{email} is already logged in.")

        conn
        |> redirect(to: conn |> Routes.page_path(:index))
    end
  end

  def logout(conn, _params) do
    conn
    |> delete_session(:email)
    |> delete_session(:name)
    |> redirect(to: conn |> Routes.page_path(:index))
  end
end
