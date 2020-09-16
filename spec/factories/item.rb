FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Item #{n}" }
    sequence(:description) { |n| "Item #{n} Description" }
    price { 100 }
    sequence(:image) { |n| "https://via.placeholder.com/150?#{n}" }
    sequence(:inventory) { |n| n }
    active? { true }
    merchant
  end
end
