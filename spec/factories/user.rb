FactoryBot.define do
  factory :user do
    name { 'Jeff Bezos' }
    address { '123 Main Street' }
    city { 'Denver' }
    state { 'CO' }
    zip { '80123' }
    sequence(:email) { |n| "jbezos#{n}@amazon.com" }
    sequence(:password) { |n| "Hunter#{n}" }
    role { 0 }
  end
end
