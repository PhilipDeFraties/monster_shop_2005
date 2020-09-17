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
frisbee = bike_shop.items.create(name: "Frisbee", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:true, inventory: 21)
slinky = bike_shop.items.create(name: "Slinky", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:true, inventory: 21)
foot = bike_shop.items.create(name: "foor", description: "Its a foot", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:true, inventory: 21)
paper = dog_shop.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
pencil = dog_shop.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
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
order_1 = Order.create!(name: "Phil", address: "5 st", city: "Lakewood", state: "CO", zip: 55555)
order_2 = Order.create!(name: "Jade", address: "5 st", city: "Lakewood", state: "CO", zip: 55555)
order_3 = Order.create!(name: "Endo", address: "5 st", city: "Lakewood", state: "CO", zip: 55555)
order_4 = Order.create!(name: "Nooch", address: "5 st", city: "Lakewood", state: "CO", zip: 55555)
item_order = ItemOrder.create!(order: order_1, item: frisbee, price: 21, quantity: 1)
item_order2 = ItemOrder.create!(order: order_2, item: slinky, price: 21, quantity: 2)
item_order3 = ItemOrder.create!(order: order_3, item: foot, price: 21, quantity: 3)
item_order4 = ItemOrder.create!(order: order_4, item: paper, price: 21, quantity: 4)
item_order5 = ItemOrder.create!(order: order_1, item: slinky, price: 21, quantity: 2)
item_order6 = ItemOrder.create!(order: order_2, item: foot, price: 21, quantity: 3)
item_order7 = ItemOrder.create!(order: order_3, item: paper, price: 21, quantity: 4)
item_order8 = ItemOrder.create!(order: order_4, item: frisbee, price: 21, quantity: 1)
