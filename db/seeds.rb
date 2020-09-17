# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ItemOrder.destroy_all
Order.destroy_all
User.destroy_all
Merchant.destroy_all
Item.destroy_all

#merchants
bike_shop = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

#dog_shop items
pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create!(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

# users
user_1 = User.create!(name: 'Jeff Bezos',
                    address: '123 Main Street',
                    city: 'Denver',
                    state: 'CO',
                    zip: '80123',
                    email: 'jbezos@amazon.com',
                    password: 'Hunter2',
                    role: 0)

merchant_1 = User.create!(name: 'Bill Gates',
                    address: '1000 Microsoft Drive',
                    city: 'Seattle',
                    state: 'WA',
                    zip: '00123',
                    email: 'bill.gates@outlook.com',
                    password: '@%)abc123#$.',
                    role: 1)

admin_1 = User.create!(name: 'John Admin',
                    address: '500 Administrator Dr.',
                    city: 'Arvada',
                    state: 'CO',
                    zip: '01011',
                    email: 'john@admin.com',
                    password: 'Hunter2',
                    role: 2)

#an order
user_1.orders.create!(name: "Human Person", address: "Address", city: "City", state: "State", zip: "12345", status: "pending")
# @order = Order.create!(name: "Human Person", address: "Address", city: "City", state: "State", zip: "12345", status: "pending")
user_1.orders[0].item_orders.create!(price: 10, quantity: 1, item: pull_toy)
user_1.orders[0].item_orders.create!(price: 10, quantity: 5, item: dog_bone)
user_1.orders[0].item_orders.create!(price: 10, quantity: 3, item: tire)
