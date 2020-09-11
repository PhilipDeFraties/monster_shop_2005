
require 'rails_helper'

describe 'As a visitor' do
  it 'I see a link to browse all items for sale' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('All Items')
      click_link 'All Items'
    end

    expect(current_path).to eq('/items')
  end

  it 'I see a link to see all merchants' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('All Merchants')
      click_link 'All Merchants'
    end

    expect(current_path).to eq('/merchants')
  end

  it 'I see a cart indicator link' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('Cart: 0')
      click_link 'Cart: 0'
    end

    expect(current_path).to eq('/cart')
  end

  it 'I see a register link' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('Register')
      click_link 'Register'
    end

    expect(current_path).to eq('/register')
  end

  it 'I see a link to home' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('Home')
      click_link 'Home'
    end

    expect(current_path).to eq('/')
  end

  it 'I see a link to login' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('Login')
      click_link 'Login'
    end

    expect(current_path).to eq('/login')
  end


  describe "as a merchant employee" do
    it "shows the same links as a regular user and a link to the merchant dashboard" do
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
        expect(page).to have_link("Home")
        expect(page).to have_link("Cart: 0")
        expect(page).to have_link("Logout")
        expect(page).to have_link("Profile")
        expect(page).to have_link("Merchant Dashboard")
        expect(page).to have_link("All Merchants")
        expect(page).to have_link("All Items")
        expect(page).to_not have_link("Login")
        expect(page).to_not have_link("Register")

      end

      within 'nav' do
        click_link 'Merchant Dashboard'
        expect(current_path).to eq('/merchant')
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

    it "When I try to access any path that begins with /admin, then I see a 404 error" do
      merchant_1 = User.create(name: 'Bill Gates',
                          address: '1000 Microsoft Drive',
                          city: 'Seattle',
                          state: 'WA',
                          zip: '00123',
                          email: 'bill.gates@outlook.com',
                          password: '@%)abc123#$.',
                          role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      visit "/admin"
      expect(page).to have_content("The page you were looking for doesn't exist.")


      admin_1 = User.create(name: 'John Admin',
                          address: '500 Administrator Dr.',
                          city: 'Arvada',
                          state: 'CO',
                          zip: '01011',
                          email: 'john@admin.com',
                          password: 'Hunter2',
                          role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)


      visit "/admin"
      expect(page).to have_content("placeholder for admin dashboard US 5")
    end
  end

  describe "As an admin" do
    it "I see the same links as regular user, plus admin dashboard and all users, minus a link to a shopping cart" do

      admin_1 = User.create(name: 'Warren Buffet',
                          address: '9999 Buffet Street',
                          city: 'New York',
                          state: 'NY',
                          zip: '70007',
                          email: 'warrenbuffet@gmail.com',
                          password: 'Password1234',
                          role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

      visit '/items'
      within 'nav' do
        expect(page).to have_link("Home")
        expect(page).to have_link("Logout")
        expect(page).to have_link("Profile")
        expect(page).to have_link("All Items")
        expect(page).to have_link("All Merchants")
        expect(page).to have_link("Admin Dashboard")
        expect(page).to have_link("Users")
        expect(page).to_not have_link("Cart: 0")
        expect(page).to_not have_link("Merchant Dashboard")
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

    it "I see a 404 error when I try to access any path that begins with /merchant or /cart" do

      admin_1 = User.create(name: 'Warren Buffet',
                          address: '9999 Buffet Street',
                          city: 'New York',
                          state: 'NY',
                          zip: '70007',
                          email: 'warrenbuffet@gmail.com',
                          password: 'Password1234',
                          role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)
      
      visit '/merchant'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/cart'
      expect(page).to have_content("The page you were looking for doesn't exist.")

    end
  end
end
