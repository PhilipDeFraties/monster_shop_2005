require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
      expect(page).to_not have_link(@dog_bone.name)
    end

    it "I can see a list of all of the items "do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

        expect(page).to_not have_link(@dog_bone.name)
        expect(page).to_not have_content(@dog_bone.description)
        expect(page).to_not have_content("Inactive")
        expect(page).to_not have_content("Inventory: #{@dog_bone.inventory}")
        expect(page).to_not have_css("img[src*='#{@dog_bone.image}']")
    end

    describe "As any kind of user on the system" do
      it "From the items page, I can click on an item's image and be directed to it's show page" do

        visit "/items"
        find(:xpath, "//a/img[@alt='#{@tire.name}-image']/..").click
        expect(current_path).to eq("/items/#{@tire.id}")
      end

      it "As an admin, I can visit the items catalog, /items, and see only active items" do

        admin_1 = User.create(name: 'Warren Buffet',
                            address: '9999 Buffet Street',
                            city: 'New York',
                            state: 'NY',
                            zip: '70007',
                            email: 'warrenbuffet@gmail.com',
                            password: 'Password1234',
                            role: 2)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

        visit "/items"

        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_link(@tire.name)
        expect(page).to_not have_link(@dog_bone.name)
      end

      it "As a default user, I can visit the items catalog, /items, and see only active items" do

        default_1 = User.create(name: 'Warren Buffet',
                            address: '9999 Buffet Street',
                            city: 'New York',
                            state: 'NY',
                            zip: '70007',
                            email: 'warrenbuffet@gmail.com',
                            password: 'Password1234',
                            role: 0)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_1)

        visit "/items"

        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_link(@tire.name)
        expect(page).to_not have_link(@dog_bone.name)
      end

      it "As a merchant user, I can visit the items catalog, /items, and see only active items" do

        merchant_1 = User.create(name: 'Warren Buffet',
                            address: '9999 Buffet Street',
                            city: 'New York',
                            state: 'NY',
                            zip: '70007',
                            email: 'warrenbuffet@gmail.com',
                            password: 'Password1234',
                            role: 1)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

        visit "/items"

        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_link(@tire.name)
        expect(page).to_not have_link(@dog_bone.name)
      end
      describe "When I visit the items index page" do
        it "I see the top 5 most popular items by quantity purchased, plus the quantity bought" do

          bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
          dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

          frisbee = bike_shop.items.create(name: "Frisbee", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:true, inventory: 21)
          slinky = bike_shop.items.create(name: "Slinky", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:true, inventory: 21)
          foot = bike_shop.items.create(name: "Foot", description: "Its a foot", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:true, inventory: 21)
          paper = dog_shop.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
          pencil = dog_shop.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
          pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

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
          item_order9 = ItemOrder.create!(order: order_2, item: frisbee, price: 21, quantity: 1)
          item_order10 = ItemOrder.create!(order: order_1, item: pencil, price: 21, quantity: 1)
          item_order11 = ItemOrder.create!(order: order_2, item: pencil, price: 21, quantity: 1)
          item_order12 = ItemOrder.create!(order: order_1, item: pull_toy, price: 21, quantity: 1)
          item_order13 = ItemOrder.create!(order: order_2, item: pull_toy, price: 21, quantity: 1)

          visit '/items'

          within '#most-popular-items' do
            expect(page).to have_content("Lined Paper: 8")
            expect(page).to have_content("Foot: 6")
            expect(page).to have_content("Slinky: 4")
            expect(page).to have_content("Frisbee: 3")
            expect(page).to have_content("Pull Toy: 2")
          end
        end
      end
    end
  end
end
