require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @item_1 = create(:item)
      @item_2 = create(:item)
      @item_3 = create(:item, active?: false)

      @item_order_1 = create(:item_order, quantity: 10)
      @item_order_2 = create(:item_order, quantity: 9)
      @item_order_3 = create(:item_order, quantity: 8)
      @item_order_4 = create(:item_order, quantity: 7)
      @item_order_5 = create(:item_order, quantity: 6)
      @item_order_6 = create(:item_order, quantity: 5)
      @item_order_7 = create(:item_order, quantity: 4)
      @item_order_8 = create(:item_order, quantity: 3)
      @item_order_9 = create(:item_order, quantity: 2)
      @item_order_10 = create(:item_order, quantity: 1)
    end

    describe 'I see an area with statistics' do
      it 'the top 5 most popular items by quantity purchased, plus the quantity bought' do
        expected_items = [@item_order_1.item, @item_order_2.item, @item_order_3.item, @item_order_4.item, @item_order_5.item]

        visit "/items"

        within "#most-popular-items" do
          expected_items.each do |item|
            expect(page).to have_content("#{item.name} #{item.total_bought}")
          end
        end
      end

      it 'the 5 least popular items by quantity purchased, plus the quantity bought' do
        expected_items = [@item_order_10.item, @item_order_9.item, @item_order_8.item, @item_order_7.item, @item_order_6.item]

        visit "/items"

        within "#least-popular-items" do
          expected_items.each do |item|
            expect(page).to have_content("#{item.name} #{item.total_bought}")
          end
        end
      end
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@item_1.name)
      expect(page).to have_link(@item_1.merchant.name)
      expect(page).to have_link(@item_2.name)
      expect(page).to have_link(@item_2.merchant.name)
      expect(page).to_not have_link(@item_3.name)
    end

    it "I can see a list of all of the items "do

      visit '/items'

      within "#item-#{@item_1.id}" do
        expect(page).to have_link(@item_1.name)
        expect(page).to have_content(@item_1.description)
        expect(page).to have_content("Price: $#{@item_1.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@item_1.inventory}")
        expect(page).to have_link(@item_1.merchant.name)
        expect(page).to have_css("img[src*='#{@item_1.image}']")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_link(@item_2.name)
        expect(page).to have_content(@item_2.description)
        expect(page).to have_content("Price: $#{@item_2.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@item_2.inventory}")
        expect(page).to have_link(@item_2.merchant.name)
        expect(page).to have_css("img[src*='#{@item_2.image}']")
      end

      expect(page).to_not have_link(@item_3.name)
      expect(page).to_not have_content(@item_3.description)
      expect(page).to_not have_content("Inactive")
      expect(page).to_not have_content("Inventory: #{@item_3.inventory}")
      expect(page).to_not have_css("img[src*='#{@item_3.image}']")
    end

    describe 'when I am logged in as any type of user' do
      before :each do
        @default_1 = create(:user)
        @merchant_1 = create(:merchant_user)
        @admin_1 = create(:admin_user)
        @users = [@default_1, @merchant_1, @admin_1]
      end

      it 'I can visit the items catalog, /items, and see only active items' do
        @users.each do |user|
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

          visit "/items"

          expect(page).to have_link(@item_2.name)
          expect(page).to have_link(@item_1.name)
          expect(page).to_not have_link(@item_3.name)
        end
      end

      it "From the items page, I can click on an item's image and be directed to it's show page" do
        @users.each do |user|
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

          visit "/items"
          find(:xpath, "//a/img[@alt='#{@item_1.name}-image']/..").click
          expect(current_path).to eq("/items/#{@item_1.id}")
        end
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
