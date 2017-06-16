require IEx

defmodule Bamboo.SendGridHelperTest do
  use ExUnit.Case

  IEx.pry
  import Bamboo.SendgridHelper

  @template_id "80509523-83de-42b6-a2bf-54b7513bd2aa"

  setup do
    {:ok, email: Bamboo.Email.new_email()}
  end

  test "with_template/2 adds the correct template", %{email: email} do
    email = email |> with_template(@template_id)
    assert email.private["x-smtpapi"] == %{
     "filters" => %{
       "templates" => %{
         "settings" => %{
           "enable" => 1,
           "template_id" => @template_id
         }
       }
     }
   }
  end
end
