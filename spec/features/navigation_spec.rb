
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')
    end

    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

    end

    it "When I click on the register link in the nav bar" do

      visit '/merchants'
      within 'nav' do
        click_link 'Register'
        expect(current_path).to eq('/users/new')
      end
    end
  end


  describe "as a merchant employee" do
    it "shows the same links as a regular user and a linnk to the merchant dashboard" do
      merchant_1 = User.create(name: 'Bill Gates',
                          address: '1000 Microsoft Drive',
                          city: 'Seattle',
                          state: 'WA',
                          zip: '00123',
                          email: 'bill.gates@outlook.com',
                          password: '@%)abc123#$.',
                          role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)


      visit '/items'

      within 'nav' do
        expect(page).to have_link("Merchant Dashboard")
        expect(page).to have_link("All Merchants")
        expect(page).to have_link("All Items")
      end

      within 'nav' do
        click_link 'Merchant Dashboard'
        expect(current_path).to eq('/merchant')
      end
    end
  end

end
