# As a registered user
# When I visit my profile page
# Then I see all of my profile data on the page except my password
# And I see a link to edit my profile data
require 'rails_helper'

RSpec.describe 'user show page', type: :feature do
  describe 'As a user' do
    before :each do
      @user = User.create(name: 'Jeff Bezos',
                          address: '123 Main Street',
                          city: 'Denver',
                          state: 'CO',
                          zip: '80123',
                          email: 'jbezos@amazon.com',
                          password: 'Hunter2',
                          role: 0)
      @mike = Merchant.create!(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @meg.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create!(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create!(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    describe "When I visit my profile page" do
      it "I see all of my profile data on the page except my password" do

        visit '/profile'

        expect(current_path).to eq('/profile')
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user.address)
        expect(page).to have_content(@user.city)
        expect(page).to have_content(@user.state)
        expect(page).to have_content(@user.zip)
        expect(page).to have_content(@user.email)
      end

      it "I see a link to edit my profile data" do
        visit '/profile'

        expect(page).to have_link('Edit Profile')
      end
    end

    describe "When I visit my profile page" do
      it "and I have orders in place, I see a link called My Orders" do
        @tire = @meg.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        @paper = @mike.items.create!(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
        @pencil = @mike.items.create!(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
        visit "/items/#{@paper.id}"
        click_on "Add To Cart"
        visit "/items/#{@tire.id}"
        click_on "Add To Cart"
        visit "/items/#{@pencil.id}"
        click_on "Add To Cart"
        visit "/cart"
        click_on "Checkout"
        fill_in 'Name', with: "#{@user.name}"
        fill_in 'Address', with: "#{@user.address}"
        fill_in 'City', with: "#{@user.city}"
        fill_in 'State', with: "#{@user.state}"
        fill_in 'Zip', with: "#{@user.zip}"
        click_on "Create Order"

        visit "/profile"
        expect(page).to have_link('My Orders')

        click_on "My Orders"
        expect(current_path).to eq("/profile/orders")
      end

      it "when I do not have orders I do not see a link My Orders" do
        visit "/profile"
        expect(page).to_not have_link('My Orders')
      end
    end
  end
end
