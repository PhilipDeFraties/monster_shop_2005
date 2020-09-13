FactoryBot.define do
  factory :admin_user, class: User do
    sequence(:name) { |n| "Merchant Name #{n}" }
    sequence(:address) { |n| "#{n} Main Street" }
    city { 'Denver' }
    state { 'CO' }
    zip { '80123' }
    sequence(:email) { |n| "merchantemail#{n}@gmail.com" }
    sequence(:password) {|n| "Hunter#{n}" }
    role { 2 }
  end
end
