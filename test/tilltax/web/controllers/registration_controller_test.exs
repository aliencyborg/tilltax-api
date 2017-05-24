defmodule TillTax.Web.RegistrationControllerTest do
  use TillTax.Web.ConnCase

  alias TillTax.Repo
  alias TillTax.Accounts.User

  @valid_attrs %{
    email: "some@email",
    password: "some-password",
    password_confirmation: "some-password"
  }
  @invalid_attrs %{
    email: nil,
    password: nil,
    password_confirmation: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates user and renders user when data is valid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), %{
      data: %{
        type: "user",
        attributes: @valid_attrs
      }
    }

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User, %{email: @valid_attrs[:email]})
  end

  test "does not create user and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), %{
      data: %{
        type: "user",
        attributes: @invalid_attrs
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end
end
