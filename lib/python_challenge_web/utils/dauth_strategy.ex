defmodule DAuth do
  use OAuth2.Strategy

  def client do
    OAuth2.Client.new([
      strategy: __MODULE__,
      client_id: System.get_env("DAUTH_CLIENT_ID"),
      client_secret: System.get_env("DAUTH_CLIENT_SECRET"),
      redirect_uri: System.get_env("BASE_URI") <> "/auth/callback",
      site: "https://auth.delta.nitt.edu",
      authorize_url: "https://auth.delta.nitt.edu/authorize",
      token_url: "https://auth.delta.nitt.edu/api/oauth/token"
    ])
    |> OAuth2.Client.put_serializer("application/json", Jason)
  end

  def authorize_url! do
    OAuth2.Client.authorize_url!(client(), scope: "email openid profile user")
  end


  def get_token!(params \\ [], headers \\ [], opts \\ []) do
    OAuth2.Client.get_token!(client(), params, headers, opts)
  end

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end
end
