require 'rails_helper'
RSpec.describe 'Profile Orders' do
  describe 'When I go to my profile order page I see link to an order show page' do
    before(:each) do
    @mike = Merchant.create!(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @user_1 = User.create!(name: 'Jeff Bezos',
                        address: '123 Main Street',
                        city: 'Denver',
                        state: 'CO',
                        zip: '80123',
                        email: 'jbezos@amazon.com',
                        password: 'Hunter2',
                        password_confirmation: 'Hunter2',
                        role: 0)
    @tire = @meg.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create!(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create!(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@tire.id}"
    click_on "Add To Cart"
    visit "/items/#{@pencil.id}"
    click_on "Add To Cart"
    @items_in_cart = [@paper,@tire,@pencil]
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

    visit "/cart"
    click_on "Checkout"
    fill_in 'Name', with: "#{@user_1.name}"
    fill_in 'Address', with: "#{@user_1.address}"
    fill_in 'City', with: "#{@user_1.city}"
    fill_in 'State', with: "#{@user_1.state}"
    fill_in 'Zip', with: "#{@user_1.zip}"
    click_on "Create Order"
    end

    it "I can click See Order and go to that order show page" do
      expect(page).to have_link("Confirmation number: #{@user_1.orders.first.id}")
      click_on "Confirmation number: #{@user_1.orders.first.id}"
      expect(current_path).to eq("/profile/orders/#{@user_1.orders.first.id}")
    end

    it "has the following information" do
      click_on "Confirmation number: #{@user_1.orders.first.id}"
      expect(page).to have_css("img[src*='#{"https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png"}']")
      expect(page).to have_content("#{@user_1.orders.first.id}")
      expect(page).to have_content(@user_1.orders.first.created_at.strftime("%m/%d/%y"))
      expect(page).to have_content(@user_1.orders.first.updated_at.strftime("%m/%d/%y"))
      expect(page).to have_content("pending")
      expect(page).to have_content(@user_1.orders.first.items.first.name)
      expect(page).to have_content(@user_1.orders.first.items.first.description)
      expect(page).to have_content(@user_1.orders.first.item_orders.first.quantity)
      expect(page).to have_content(@user_1.orders.first.item_orders.first.price)
      expect(page).to have_content(@user_1.orders.first.item_orders.first.subtotal)
      expect(page).to have_content("Number of Items in Order: #{@user_1.orders.first.items.count}")
      expect(page).to have_content("Total: $122.00")
    end
  end
end
