require 'rails_helper'
# As a merchant employee
# When I visit my merchant dashboard ("/merchant")
# I see the name and full address of the merchant I work for

RSpec.describe 'merchant-employee show page', type: :feature do
  describe 'When I visit my merchant dashboard ("/merchant") as a merchant-employee' do
    before :each do
      @merchant_1 = User.create!(name: 'We Sell Feet',
                          address: '1000 Microsoft Drive',
                          city: 'Seattle',
                          state: 'WA',
                          zip: '00123',
                          email: 'bill.gates@outlook.com',
                          password: '@%)abc123#$.',
                          role: 1)
    end
    it "I see the name and full address of the merchant I work for" do
      visit '/login'

      fill_in :email, with: @merchant_1.email
      fill_in :password, with: @merchant_1.password

      click_on "Log In"

      expect(current_path).to eq("/merchant")
      expect(page).to have_content("Welcome, #{@merchant_1.name}, you are logged in!")
      save_and_open_page
      within "#merchant-address" do
        expect(page).to have_content("#{@merchant_1.address}")
        expect(page).to have_content("#{@merchant_1.city}")
        expect(page).to have_content("#{@merchant_1.state}")
        expect(page).to have_content("#{@merchant_1.zip}")
        expect(page).to have_content("#{@merchant_1.email}")
      end
    end

  end
end
