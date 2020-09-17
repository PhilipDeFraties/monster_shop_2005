require 'rails_helper'

RSpec.describe 'admin view of merchant show page' do
  describe 'When I visit the merchant dashboard ("admin/merchant/6") as an admin' do
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

      @admin_1 = User.create(name: 'John Admin',
                          address: '500 Administrator Dr.',
                          city: 'Arvada',
                          state: 'CO',
                          zip: '01011',
                          email: 'john@admin.com',
                          password: 'Hunter2',
                          role: 2)



      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @other = @bike_shop.items.create(name: "Not skins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @order = Order.create(name: "Human Person", address: "Address", city: "City", state: "State", zip: "12345", status: "pending", user_id: @user_1.id)
      ItemOrder.create(order_id: @order.id, item_id: @tire.id, price: 100, quantity: 15)
      ItemOrder.create(order_id: @order.id, item_id: @other.id, price: 100, quantity: 15)
    end

    it "I see the name and full address of the merchant" do
      visit '/login'

      fill_in :email, with: @admin_1.email
      fill_in :password, with: @admin_1.password
      click_on "Log In"

      visit "/merchants"
      expect(page).to have_link("Meg's Bike Shop")
      click_on "Meg's Bike Shop"
      #save_and_open_page
      expect(current_path).to eq("/admin/merchants/#{@bike_shop.id}")

    end
    it "I see the name and full address of the merchant" do
      visit '/login'

      fill_in :email, with: @admin_1.email
      fill_in :password, with: @admin_1.password
      click_on "Log In"

      visit "/admin/merchants/6"

      within "#merchant-address" do
        expect(page).to have_content("#{@merchant_1.address}")
        expect(page).to have_content("#{@merchant_1.city}")
        expect(page).to have_content("#{@merchant_1.state}")
        expect(page).to have_content("#{@merchant_1.zip}")
        expect(page).to have_content("#{@merchant_1.email}")
      end
    end

    # it "has a link to any orders that contain items that the merchant sells" do
    #   visit '/login'
    #
    #   fill_in :email, with: @admin_1.email
    #   fill_in :password, with: @admin_1.password
    #   click_on "Log In"
    #
    #   visit "/merchant"
    #
    #   expect(page).to have_link("Order ID: #{@order.id}")
    #
    #   @bike_shop.items.each do |item|
    #     expect(page).to have_content(@order.id)
    #     expect(page).to have_content(@order.created_at.strftime("%m/%d/%y"))
    #     expect(page).to have_content(@order.items.count)
    #     expect(page).to have_content(item.name)
    #   end
    #   expect(page).to have_content("$3,000")
    # end

    # it "has a link to a merchant employee index page containing all items" do
    #   visit '/login'
    #
    #   fill_in :email, with: @admin_1.email
    #   fill_in :password, with: @admin_1.password
    #   click_on "Log In"
    #
    #   visit "/merchant"
    #   save_and_open_page
    #   expect(page).to have_link("View Items")
    #   click_on "View Items"
    #
    #   expect(current_path).to eq("/merchant/items")
    #
    #   expect(page).to have_content(@tire.name)
    #   expect(page).to have_content(@other.name)
    #
    # end

  end
end
