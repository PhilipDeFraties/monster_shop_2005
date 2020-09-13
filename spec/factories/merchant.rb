FactoryBot.define do
  factory :merchant do
    name { "Meg's Bike Shop" }
    address { '123 Bike Rd.' }
    city { 'Denver' }
    state { 'CO' }
    zip { 80203 }
  end
end
