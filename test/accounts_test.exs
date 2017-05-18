require IEx;

defmodule TillTax.AccountsTest do
  use TillTax.DataCase

  alias TillTax.Accounts
  alias TillTax.Accounts.User

  @create_attrs %{
    email: "some@email",
    password: "some-password",
    password_confirmation: "some-password"
  }
  @update_attrs %{
    email: "some.updated@email",
    password: "some-updated-password",
    password_confirmation: "some-updated-password"
  }

  def fixture(:user, attrs \\ @create_attrs) do
    {:ok, user} = Accounts.create_user(attrs)
    user
  end

  def fixture_without_password(:user) do
    user = fixture(:user)
    %{user | password: nil, password_confirmation: nil}
  end

  test "list_users/1 returns all users" do
    user = fixture_without_password(:user)
    assert Accounts.list_users() == [user]
  end

  test "get_user! returns the user with given id" do
    user = fixture_without_password(:user)
    assert Accounts.get_user!(user.id) == user
  end

  test "create_user/1 with valid data creates a user" do
    assert {:ok, %User{}} = Accounts.create_user(@create_attrs)
  end

  test "create_user/1 with invalid data returns error changeset" do
    attrs = %{email: nil, password: nil}
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
  end

  test "create_user/1 with mis-matched passwords returns error changeset" do
    attrs = %{@create_attrs | password_confirmation: 'oopsy-doopsy'}
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
  end

  test "create_user/1 with no password_confirmation returns error changeset" do
    attrs = %{@create_attrs | password_confirmation: nil}
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
  end

  test "create_user/1 with short password returns error changeset" do
    attrs = %{
      email: "some@email",
      password: "shorty",
      password_confirmation: "shorty"
    }
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
  end

  test "update_user/2 with valid data updates the user" do
    user = fixture(:user)
    assert {:ok, user} = Accounts.update_user(user, @update_attrs)
    assert %User{} = user
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = fixture_without_password(:user)
    assert {:error, %Ecto.Changeset{}} =
      Accounts.update_user(user, %{email: 'derp'})
    assert user == Accounts.get_user!(user.id)
  end

  test "delete_user/1 deletes the user" do
    user = fixture(:user)
    assert {:ok, %User{}} = Accounts.delete_user(user)
    assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
  end

  test "change_user/1 returns a user changeset" do
    user = fixture(:user)
    assert %Ecto.Changeset{} = Accounts.change_user(user)
  end
end
