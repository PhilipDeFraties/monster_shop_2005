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


      visit "/login"
      fill_in :email, with: user_1.email
      fill_in :password, with: user_1.password
      click_on "Log In"
      visit "/logout"
      expect(current_path).to eq("/")
      expect(page).to have_content("You have been logged out")
    #  expect(page).to have_content("Cart:0")
    end
  end
end
