require IEx;

defmodule TillTax.AccountsTest do
  use TillTax.DataCase

  alias TillTax.Accounts

  describe "users" do
    alias TillTax.Accounts.User

    @valid_attrs %{
      admin: false,
      email: "some@email",
      password: "some-password",
      password_confirmation: "some-password"
    }
    @update_attrs %{
      admin: true,
      email: "some.updated@email",
      password: "some-updated-password",
      password_confirmation: "some-updated-password"
    }
    @invalid_attrs %{
      admin: nil,
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
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.admin == false
      assert user.email == "some@email"
      assert user.password == "some-password"
      assert user.password_confirmation == "some-password"
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
        admin: false,
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
      assert user.admin == true
      assert user.email == "some.updated@email"
      assert user.password == "some-updated-password"
      assert user.password_confirmation == "some-updated-password"
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

  describe "contacts" do
    alias TillTax.Accounts.Contact

    @valid_attrs %{
      details: %{},
      email: "some@email",
      name: "some name",
      phone: "651-555-1234"
    }
    @update_attrs %{
      details: %{},
      email: "some.updated@email",
      name: "some updated name",
      phone: "651-555-1234 ext 99"
    }
    @invalid_attrs %{
      details: nil,
      email: nil,
      name: nil,
      phone: nil
    }

    def contact_fixture(attrs \\ %{}) do
      {:ok, contact} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_contact()

      contact
    end

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert Accounts.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Accounts.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      assert {:ok, %Contact{} = contact} = Accounts.create_contact(@valid_attrs)
      assert contact.details == %{}
      assert contact.email == "some@email"
      assert contact.name == "some name"
      assert contact.phone == "651-555-1234"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      assert {:ok, contact} = Accounts.update_contact(contact, @update_attrs)
      assert %Contact{} = contact
      assert contact.details == %{}
      assert contact.email == "some.updated@email"
      assert contact.name == "some updated name"
      assert contact.phone == "651-555-1234 ext 99"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} =
        Accounts.update_contact(contact, @invalid_attrs)
      assert contact == Accounts.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Accounts.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Accounts.change_contact(contact)
    end
  end
end
