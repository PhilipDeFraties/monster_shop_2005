
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
    it "When I click on the register link in the nav bar" do
      visit '/items'

      within 'nav' do
        expect(page).to have_content("Merchant Dashboard")
      end

      within 'nav' do
        click_link 'Merchant Dashboard'
        expect(current_path).to eq('/merchants')
      end
    end
  end

end
