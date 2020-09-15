require 'rails_helper'
RSpec.describe 'Cart show' do
  describe 'When I have added items to my cart' do
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
    end
    it 'Theres a link to checkout' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit "/cart"
      expect(page).to have_link("Checkout")
      click_on "Checkout"
      expect(current_path).to eq("/orders/new")
    end
    it 'I fill out order info, and an order is created in the system with a pending status' do
      visit "/login"
      fill_in 'Email', with: @user_1.email
      fill_in 'Password', with: @user_1.password
      click_on("Log In")
      visit "/cart"
      click_on "Checkout"
      fill_in 'Name', with: "#{@user_1.name}"
      fill_in 'Address', with: "#{@user_1.address}"
      fill_in 'City', with: "#{@user_1.city}"
      fill_in 'State', with: "#{@user_1.state}"
      fill_in 'Zip', with: "#{@user_1.zip}"
      click_on "Create Order"
      expect(current_path).to eq("/profile/orders")
      save_and_open_page
      expect(page).to have_content("Your order has been created!")
      expect(page).to have_content(@paper.name)
      expect(page).to have_content(@paper.merchant.name)
      expect(page).to have_content(@tire.name)
      expect(page).to have_content(@tire.merchant.name)
      expect(page).to have_content(@pencil.name)
      expect(page).to have_content(@pencil.merchant.name)
    end
  end
  describe 'When I havent added items to my cart' do
    it 'There is not a link to checkout' do
      visit "/cart"
      expect(page).to_not have_link("Checkout")
    end
  end
end
