require IEx;

defmodule TillTax.AccountsTest do
  use TillTax.DataCase

  alias TillTax.Accounts

  describe "users" do
    alias TillTax.Accounts.User

    @valid_attrs %{
      email: "some@email",
      password: "some-password",
      password_confirmation: "some-password"
    }
    @update_attrs %{
      email: "some.updated@email",
      password: "some-updated-password",
      password_confirmation: "some-updated-password"
    }
    @invalid_attrs %{
      email: nil,
      password: nil,
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    def user_fixture_response(attrs \\ %{}) do
      user_fixture(attrs)
      |> Map.merge(%{password: nil, password_confirmation: nil})
    end

    test "list_users/0 returns all users" do
      user = user_fixture_response()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture_response()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{}} = Accounts.create_user(@valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "create_user/1 with mis-matched passwords returns error changeset" do
      attrs = %{@valid_attrs | password_confirmation: 'oopsy-doopsy'}
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
    end

    test "create_user/1 with no password_confirmation returns error changeset" do
      attrs = %{@valid_attrs | password_confirmation: nil}
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
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture_response()
      assert {:error, %Ecto.Changeset{}} =
        Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
