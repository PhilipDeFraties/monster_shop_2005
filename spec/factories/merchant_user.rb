FactoryBot.define do
  factory :merchant_user, class: User do
    name { 'Warren Buffet' }
    address { '9999 Buffet Street' }
    city { 'New York' }
    state { 'NY' }
    zip { '70007' }
    email { 'warrenbuffet@gmail.com' }
    password { 'Password1234' }
    role { 1 }
  end
end
