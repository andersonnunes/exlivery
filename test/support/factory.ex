defmodule Exlivery.Factory do
  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  use ExMachina

  def user_factory do
    %User{
      name: "Anderson",
      email: "anderson@email.com",
      cpf: "0123456789",
      age: 34,
      address: "Avenida Paulista, 65"
    }
  end

  def item_factory do
    %Item{
      description: "Pizza de frango",
      category: :pizza,
      unity_price: Decimal.new("35.5"),
      quantity: 1
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Avenida Paulista, 65",
      items: [
        build(:item),
        build(:item,
          description: "Temaki de atum",
          category: :japonesa,
          quantity: 2,
          unity_price: Decimal.new("20.50")
        )
      ],
      total_price: Decimal.new("76.50"),
      user_cpf: "0123456789"
    }
  end
end
