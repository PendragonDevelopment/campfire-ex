defmodule Campfire.Plugs.User do
  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user =
      with headers when headers != [] <- Plug.Conn.get_req_header(conn, "user-id"),
           {:ok, user} <- Campfire.Api.get(Campfire.Accounts.User, hd(headers)) do
        user
      else
        _ ->
          nil
      end

    conn
    |> Plug.Conn.assign(:actor, user)
    |> Absinthe.Plug.put_options(context: %{actor: user})
  end
end
