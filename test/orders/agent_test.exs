defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.{Item, Order}

  import Exlivery.Factory

  describe "save/1" do
    test "saves the order" do
      order = build(:order)

      OrderAgent.start_link(%{})

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})

      :ok
    end

    test "when the order is found, returns the order" do
      {:ok, uuid} =
        :order
        |> build()
        |> OrderAgent.save()

      response = OrderAgent.get(uuid)

      expected_response =
        {:ok,
         %Order{
           delivery_address: "Avenida Paulista, 65",
           items: [
             %Item{
               description: "Pizza de frango",
               category: :pizza,
               unity_price: Decimal.new("35.5"),
               quantity: 1
             },
             %Item{
               description: "Temaki de atum",
               category: :japonesa,
               unity_price: Decimal.new("20.50"),
               quantity: 2
             }
           ],
           total_price: Decimal.new("76.50"),
           user_cpf: "0123456789"
         }}

      assert response == expected_response
    end

    test "when the order is not found, returns an error" do
      response = OrderAgent.get("00000000000")

      expected_response = {:error, "Order not found"}

      assert response == expected_response
    end
  end
end
