defmodule TillTax.Web.SessionControllerTest do
  use TillTax.Web.ConnCase

  alias TillTax.Accounts
  alias TillTax.Accounts.Session

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:session) do
    {:ok, session} = Accounts.create_session(@create_attrs)
    session
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, session_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates session and renders session when data is valid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, session_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id}
  end

  test "does not create session and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen session and renders session when data is valid", %{conn: conn} do
    %Session{id: id} = session = fixture(:session)
    conn = put conn, session_path(conn, :update, session), session: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, session_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id}
  end

  test "does not update chosen session and renders errors when data is invalid", %{conn: conn} do
    session = fixture(:session)
    conn = put conn, session_path(conn, :update, session), session: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen session", %{conn: conn} do
    session = fixture(:session)
    conn = delete conn, session_path(conn, :delete, session)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, session_path(conn, :show, session)
    end
  end
end