FactoryBot.define do
  factory :merchant_user, class: User do
    name { 'Warren Buffet' }
    address { '9999 Buffet Street' }
    city { 'New York' }
    state { 'NY' }
    zip { '70007' }
    sequence(:email) { |n| "merchantemail#{n}@gmail.com" }
    sequence(:password) {|n| "Hunter#{n}" }
    sequence(:password_confirmation) {|n| "Hunter#{n}" }
    role { 1 }
  end
end
