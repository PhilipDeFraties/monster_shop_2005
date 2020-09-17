
require 'rails_helper'

RSpec.describe 'merchant-employee show page', type: :feature do
  describe 'When I visit my merchant dashboard ("/merchant") as a merchant-employee' do
    before :each do
      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @merchant_1 = User.create(name: 'Bill Gates',
                          address: '1000 Microsoft Drive',
                          city: 'Seattle',
                          state: 'WA',
                          zip: '00123',
                          email: 'bill.gates@outlook.com',
                          password: '@%)abc123#$.',
                          merchant_id: @bike_shop.id,
                          role: 1)

      @user_1 = User.create!(name: 'Jeff Bezos',
                    address: '123 Main Street',
                    city: 'Denver',
                    state: 'CO',
                    zip: '80123',
                    email: 'jbezos@amazon.com',
                    password: 'Hunter2',
                    role: 0)



      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @other = @bike_shop.items.create(name: "Not skins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @order = Order.create(name: "Human Person", address: "Address", city: "City", state: "State", zip: "12345", status: "pending", user_id: @user_1.id)
      ItemOrder.create(order_id: @order.id, item_id: @tire.id, price: 100, quantity: 15)
      ItemOrder.create(order_id: @order.id, item_id: @other.id, price: 100, quantity: 15)

    end

    it "I see the name and full address of the merchant I work for" do
      visit '/login'

      fill_in :email, with: @merchant_1.email
      fill_in :password, with: @merchant_1.password
      click_on "Log In"

      expect(current_path).to eq("/merchant")
      expect(page).to have_content("Welcome, #{@merchant_1.name}, you are logged in!")

      within "#merchant-address" do
        expect(page).to have_content("#{@bike_shop.address}")
        expect(page).to have_content("#{@bike_shop.city}")
        expect(page).to have_content("#{@bike_shop.state}")
        expect(page).to have_content("#{@bike_shop.zip}")
      end
    end

    it "has a link to any orders that contain items I sell" do
      visit '/login'

      fill_in :email, with: @merchant_1.email
      fill_in :password, with: @merchant_1.password
      click_on "Log In"

      visit "/merchant"

      expect(page).to have_link("Order ID: #{@order.id}")

      @bike_shop.items.each do |item|
        expect(page).to have_content(@order.id)
        expect(page).to have_content(@order.created_at.strftime("%m/%d/%y"))
        expect(page).to have_content(@order.items.count)
        expect(page).to have_content(item.name)
      end
      expect(page).to have_content("$3,000")
    end

    it "has a link to a merchant employee index page containing all items" do
      visit '/login'

      fill_in :email, with: @merchant_1.email
      fill_in :password, with: @merchant_1.password
      click_on "Log In"

      visit "/merchant"
      expect(page).to have_link("View Items")
      click_on "View Items"

      expect(current_path).to eq("/merchant/items")

      expect(page).to have_content(@tire.name)
      expect(page).to have_content(@other.name)
    end
  end
end