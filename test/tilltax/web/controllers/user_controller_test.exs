defmodule TillTax.Web.UserControllerTest do
  use TillTax.Web.ConnCase

  alias TillTax.Accounts

  @create_attrs %{
    "email" => "some@email",
    "password" => "some-password",
    "password-confirmation" => "some-password"
  }

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end
end
