FactoryBot.define do
  factory :item_order do
    price { 10 }
    quantity { 1 }
    item
    order
  end
end
