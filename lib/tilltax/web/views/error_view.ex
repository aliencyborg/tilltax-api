defmodule TillTax.Web.ErrorView do
  use TillTax.Web, :view
  use JaSerializer.PhoenixView

  def render("400.json", _assigns) do
    %{title: "Bad Request", code: 400}
    |> JaSerializer.ErrorSerializer.format
  end

  def render("401.json", _assigns) do
    %{title: "Unauthorized", code: 401}
    |> JaSerializer.ErrorSerializer.format
  end

  def render("404.json", _assigns) do
    %{title: "Page not found", code: 404}
    |> JaSerializer.ErrorSerializer.format
  end

  def render("422.json", _assigns) do
    %{title: "Unprocessable Entity", code: 422}
    |> JaSerializer.ErrorSerializer.format
  end

  def render("500.json", _assigns) do
    %{title: "Internal server error", code: 500}
    |> JaSerializer.ErrorSerializer.format
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end
end
