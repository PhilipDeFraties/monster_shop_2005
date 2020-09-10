
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
  describe 'As an Admin' do
    it "I see the same links as a visitor, plus admin dashboard and all users, minus a link to my shopping cart" do

      admin_1 = User.create(name: 'A',
                          address: 'B',
                          city: 'Denver',
                          state: 'CO',
                          zip: '12345',
                          email: 'admin@admin.com',
                          password: 'Hunter2',
                          role: 1)

      visit '/items'
      within 'nav' do
        expect(page).to have_content('Admin Dashboard')
        expect(page).to have_content('Users')
        expect(page).to_not have_content('Cart')
      end
    end
  end
end
