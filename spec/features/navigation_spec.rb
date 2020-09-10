
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


  describe 'As an Admin' do
    it "I see the same links as a visitor, plus admin dashboard and all users links, minus a link to a shopping cart" do

      admin_1 = User.create(name: 'John Admin',
                          address: '123 Main Street',
                          city: 'Denver',
                          state: 'CO',
                          zip: '12345',
                          email: 'john@admin.com',
                          password: 'Hunter2',
                          role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

      visit '/items'
      within 'nav' do
        expect(page).to have_link('Admin Dashboard')
        expect(page).to have_link('Users')
        expect(page).to_not have_link('Cart')
      end

      within 'nav' do
        click_link 'Admin Dashboard'
        expect(current_path).to eq('/admin')
      end

      within 'nav' do
        click_link 'Users'
        expect(current_path).to eq('/admin/users')
      end
    end
  end

end
