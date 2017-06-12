require IEx

defmodule TillTax.Web.ContactControllerTest do
  use TillTax.Web.ConnCase

  alias TillTax.Accounts
  alias TillTax.Accounts.Contact
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

  createDetails = Poison.encode!(%{
    filingStatus: "individual",
    filingRegion: "MN",
    filingYears: [2016]
  })

  updateDetails = Poison.encode!(%{
    filingStatus: "business",
    filingRegion: "DC",
    filingYears: [2015,2016]
  })

  @create_attrs %{
    details: createDetails,
    email: "some email",
    name: "some name",
    phone: "some phone"
  }
  @update_attrs %{
    details: updateDetails,
    email: "some updated email",
    name: "some updated name",
    phone: "some updated phone"
  }
  @invalid_attrs %{
    details: nil,
    email: nil,
    name: nil,
    phone: nil
  }

  def fixture(:contact) do
    {:ok, contact} = Accounts.create_contact(%{
      email: "fixture email",
      name: "fixture name",
      phone: "fixture phone",
      details: %{
        filingStatus: "individual",
        filingRegion: "MN",
        filingYears: [2016]
      }
    })
    contact
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

  test "creates contact and renders contact when data are valid",
  %{conn: conn} do
    conn = post conn, contact_path(conn, :create), data: %{
     type: "contacts",
     attributes: @create_attrs
   }

    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, contact_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "attributes" => %{
        "details" => %{
          "filingStatus" => "individual",
          "filingRegion" => "MN",
          "filingYears" => [2016]
        },
        "email" => "some email",
        "name" => "some name",
        "phone" => "some phone"
      },
      "id" => id,
      "type" => "contacts"
    }
  end

  test "does not create contact and renders errors when data are invalid",
  %{conn: conn} do
    conn = post conn, contact_path(conn, :create), data: %{
     type: "contacts",
     attributes: @invalid_attrs
   }
    assert json_response(conn, 422)["errors"] != %{}
  end

  @tag :login
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, contact_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  @tag :login
  test "updates chosen contact and renders contact when data are valid",
  %{conn: conn} do
    %Contact{id: id} = contact = fixture(:contact)
    conn = put conn, contact_path(conn, :update, contact), data: %{
      type: "contacts",
      attributes: @update_attrs
    }
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, contact_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "attributes" => %{
        "details" => %{
          "filingStatus" => "business",
          "filingRegion" => "DC",
          "filingYears" => [2015,2016]
        },
        "email" => "some updated email",
        "name" => "some updated name",
        "phone" => "some updated phone"
      },
      "id" => id,
      "type" => "contacts"
    }
  end

  @tag :login
  test "does not update chosen contact and renders errors when data are invalid",
  %{conn: conn} do
    contact = fixture(:contact)
    conn = put conn, contact_path(conn, :update, contact), data: %{
      type: "contacts",
      attributes: @invalid_attrs
    }
    assert json_response(conn, 422)["errors"] != %{}
  end

  @tag :login
  test "deletes chosen contact", %{conn: conn} do
    contact = fixture(:contact)
    conn = delete conn, contact_path(conn, :delete, contact)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, contact_path(conn, :show, contact)
    end
  end
end
