defmodule TillTax.Web.RegistrationControllerTest do
  use TillTax.Web.ConnCase

  alias TillTax.Repo
  alias TillTax.Accounts.User

  @create_attrs %{
    "email" => "some@email",
    "password" => "some-password",
    "password-confirmation" => "some-password"
  }
  @invalid_attrs %{
    "email" => "some@email",
    "password" => "",
    "password-confirmation" => ""
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates user and renders user when data are valid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), %{
      data: %{
        type: "users",
        attributes: @create_attrs
      }
    }

    assert %{"id" => id} = json_response(conn, 201)["data"]

    assert json_response(conn, 201)["data"]["id"] == id
    assert Repo.get_by(User, %{email: @create_attrs["email"]})
  end

  test "does not create user and renders errors when data are invalid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), %{
      data: %{
        type: "users",
        attributes: @invalid_attrs
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end
end
