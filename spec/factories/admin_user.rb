FactoryBot.define do
  factory :admin, class: User do
    name { 'Jeff Bezos' }
    address { '123 Main Street' }
    city { 'Denver' }
    state { 'CO' }
    zip { '80123' }
    email { 'jbezos@amazon.com' }
    password { 'Hunter2' }
    role { 2 }
  end
end
