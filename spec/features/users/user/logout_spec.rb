require 'rails_helper'

RSpec.describe "Logging Out" do

  describe "As a registered user" do
    it "redirects me to the welcome home page and I see a flash message and all items in cart are deleted" do
      user_1 = User.create(name: 'Jeff Bezos',
                          address: '123 Main Street',
                          city: 'Denver',
                          state: 'CO',
                          zip: '80123',
                          email: 'jbezos@amazon.com',
                          password: 'Hunter2',
                          role: 0)
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      visit "/login"
      fill_in :email, with: user_1.email
      fill_in :password, with: user_1.password
      click_on "Log In"

      visit "/items/#{tire.id}"
      click_on "Add To Cart"

      within 'nav' do
        expect(page).to have_link('Cart: 1')
      end

      within 'nav' do
        expect(page).to have_link('Logout')
        click_link "Logout"
      end

      expect(current_path).to eq("/")
      expect(page).to have_content("Cart: 0")
      expect(page).to have_content("You have been logged out")
    end
  end
end
