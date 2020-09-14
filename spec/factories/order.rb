FactoryBot.define do
  factory :order do
    name { 'Meg' }
    address { '123 Stang Ave' }
    city { 'Hershey' }
    state { 'PA' }
    zip { 17033 }
    status { 'pending' }
    user
  end
end
