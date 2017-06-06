defmodule TillTax.Web.UserControllerTest do
  use TillTax.Web.ConnCase

  alias TillTax.Accounts.User
  alias TillTax.Repo

  defp insert_admin do
    %User{
      id: 123,
      admin: true,
      email: "admin@email",
      password: Comeonin.Bcrypt.hashpwsalt("secretsauce")
    } |> Repo.insert!

    Repo.get(User, 123)
  end

  setup %{conn: conn} = config do
    cond do
      config[:login] ->
        user = insert_admin()
        signed_conn = Guardian.Plug.api_sign_in(conn, user)
        {:ok, conn: put_req_header(signed_conn, "accept", "application/json")}
      true ->
        {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end
  end

  @tag :login
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200)["data"] == [%{
      "attributes" => %{"admin" => true, "email" => "admin@email"},
      "id" => 123,
      "type" => "user"
    }]
  end

  test "does not list entries and renders errors when not logged in",
  %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 401)["errors"] != %{}
  end

  @tag :login
  test "returns current user on current", %{conn: conn} do
    conn = get conn, user_path(conn, :current)
    assert json_response(conn, 200)["data"] == %{
      "attributes" => %{"admin" => true, "email" => "admin@email"},
      "id" => 123,
      "type" => "user"
    }
  end

  test "does not return current usert and renders errors when not logged in",
  %{conn: conn} do
    conn = get conn, user_path(conn, :current)
    assert json_response(conn, 401)["errors"] != %{}
  end
end
