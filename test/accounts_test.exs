defmodule TillTax.AccountsTest do
  use TillTax.DataCase

  alias TillTax.Accounts
  alias TillTax.Accounts.Session

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:session, attrs \\ @create_attrs) do
    {:ok, session} = Accounts.create_session(attrs)
    session
  end

  test "list_sessions/1 returns all sessions" do
    session = fixture(:session)
    assert Accounts.list_sessions() == [session]
  end

  test "get_session! returns the session with given id" do
    session = fixture(:session)
    assert Accounts.get_session!(session.id) == session
  end

  test "create_session/1 with valid data creates a session" do
    assert {:ok, %Session{} = session} = Accounts.create_session(@create_attrs)
  end

  test "create_session/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Accounts.create_session(@invalid_attrs)
  end

  test "update_session/2 with valid data updates the session" do
    session = fixture(:session)
    assert {:ok, session} = Accounts.update_session(session, @update_attrs)
    assert %Session{} = session
  end

  test "update_session/2 with invalid data returns error changeset" do
    session = fixture(:session)
    assert {:error, %Ecto.Changeset{}} = Accounts.update_session(session, @invalid_attrs)
    assert session == Accounts.get_session!(session.id)
  end

  test "delete_session/1 deletes the session" do
    session = fixture(:session)
    assert {:ok, %Session{}} = Accounts.delete_session(session)
    assert_raise Ecto.NoResultsError, fn -> Accounts.get_session!(session.id) end
  end

  test "change_session/1 returns a session changeset" do
    session = fixture(:session)
    assert %Ecto.Changeset{} = Accounts.change_session(session)
  end
end
