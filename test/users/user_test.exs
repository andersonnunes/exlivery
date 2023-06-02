defmodule Exlivery.Users.UserTest do
  alias Exlivery.Users.User

  use ExUnit.Case

  describe "build/5" do
    test "when all params are valid, returns the user" do
      response =
        User.build(
          "Avenida Paulista",
          "Anderson",
          "anderson@email.com",
          "0123456789",
          34
        )

      expected_response =
        {:ok,
         %User{
           address: "Avenida Paulista",
           name: "Anderson",
           email: "anderson@email.com",
           cpf: "0123456789",
           age: 34
         }}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      response =
        User.build(
          "Avenida Paulista",
          "Anderson Jr",
          "anderson@email.com",
          "0123456789",
          15
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
