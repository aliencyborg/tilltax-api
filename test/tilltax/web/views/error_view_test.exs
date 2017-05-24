defmodule TillTax.Web.ErrorViewTest do
  use TillTax.Web.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "render 400.json" do
    assert render(TillTax.Web.ErrorView, "400.json", []) == %{
     "errors" => [%{code: 400, title: "Bad Request"}],
     "jsonapi" => %{"version" => "1.0"}
   }
  end

  test "render 401.json" do
    assert render(TillTax.Web.ErrorView, "401.json", []) == %{
     "errors" => [%{code: 401, title: "Unauthorized"}],
     "jsonapi" => %{"version" => "1.0"}
   }
  end

  test "render 403.json" do
    assert render(TillTax.Web.ErrorView, "403.json", []) == %{
     "errors" => [%{code: 403, title: "Forbidden"}],
     "jsonapi" => %{"version" => "1.0"}
   }
  end

  test "renders 422.json" do
    assert render(TillTax.Web.ErrorView, "422.json", []) == %{
     "errors" => [%{code: 422, title: "Unprocessable Entity"}],
     "jsonapi" => %{"version" => "1.0"}
   }
  end

  test "renders 404.json" do
    assert render(TillTax.Web.ErrorView, "404.json", []) == %{
     "errors" => [%{code: 404, title: "Page not found"}],
     "jsonapi" => %{"version" => "1.0"}
   }
  end

  test "render 500.json" do
    assert render(TillTax.Web.ErrorView, "500.json", []) == %{
     "errors" => [%{code: 500, title: "Internal server error"}],
     "jsonapi" => %{"version" => "1.0"}
   }
  end

  test "render any other" do
    assert render(TillTax.Web.ErrorView, "505.json", []) == %{
     "errors" => [%{code: 500, title: "Internal server error"}],
     "jsonapi" => %{"version" => "1.0"}
   }
  end
end
