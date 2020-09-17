require 'rails_helper'
# As an admin
# When I visit the admin's merchant index page ('/admin/merchants')
# I see a "disable" button next to any merchants who are not yet disabled
# When I click on the "disable" button
# I am returned to the admin's merchant index page where I see that the merchant's account is now disabled
# And I see a flash message that the merchant's account is now disabled

RSpec.describe "As an admin", type: :feature do
  describe 'When I visit my merchants index page' do
    before :each do
    @admin_1 = User.create(name: 'John Admin',
                        address: '500 Administrator Dr.',
                        city: 'Arvada',
                        state: 'CO',
                        zip: '01011',
                        email: 'john@admin.com',
                        password: 'Hunter2',
                        role: 2)

    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    end

    it "I see a list of all merchants" do

      visit '/login'

      fill_in :email, with: @admin_1.email
      fill_in :password, with: @admin_1.password
      click_on "Log In"

      visit '/admin/merchants'

      expect(page).to have_content(@bike_shop.name)
      expect(page).to have_content(@dog_shop.name)
    end

    it "Next to each merchant I see a button to disable it" do

      visit '/login'

      fill_in :email, with: @admin_1.email
      fill_in :password, with: @admin_1.password
      click_on "Log In"

      visit '/admin/merchants'

      Merchant.all.each do |merchant|
        within "#merchant-#{merchant.id}"
        expect(page).to have_content('Enabled')
        expect(page).to have_button('Disable')
      end
    end
  end
end
