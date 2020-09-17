require 'rails_helper'

RSpec.describe "Logging In" do
  before :each do
    @user = User.create!(name: 'Jeff Bezos',
                        address: '123 Main Street',
                        city: 'Denver',
                        state: 'CO',
                        zip: '80123',
                        email: 'jbezos@amazon.com',
                        password: 'Hunter2',
                        role: 0)
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @merchant_1 = User.create!(name: 'Bill Gates',
                        address: '1000 Microsoft Drive',
                        city: 'Seattle',
                        state: 'WA',
                        zip: '00123',
                        email: 'bill.gates@outlook.com',
                        password: '@%)abc123#$.',
                        merchant_id: @bike_shop.id,
                        role: 1)
    @admin_1 = User.create!(name: 'Phil DeFraties',
                        address: '1000 Microsoft Drive',
                        city: 'Seattle',
                        state: 'WA',
                        zip: '00123',
                        email: 'Phil.gates@outlook.com',
                        password: '@%)abc123#$.',
                        role: 2)
    end
  describe "When I log in as a regular user with valid credentials" do
    it "I am redirected to my profile page" do

      visit "/login"

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password

      click_on "Log In"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("Welcome, #{@user.name}, you are logged in!")
    end
  end


  describe "When I log in as a merchant with valid credentials" do
    it "I am redirected to my merchant dashboard page" do

      visit "/login"

      fill_in :email, with: @merchant_1.email
      fill_in :password, with: @merchant_1.password

      click_on "Log In"

      expect(current_path).to eq("/merchant")
      expect(page).to have_content("Welcome, #{@merchant_1.name}, you are logged in!")
    end
  end

  describe "When I log in as a admin with valid credentials" do
    it "I am redirected to my admin dashboard page" do

      visit "/login"

      fill_in :email, with: @admin_1.email
      fill_in :password, with: @admin_1.password

      click_on "Log In"
      expect(current_path).to eq("/admin")
      expect(page).to have_content("Welcome, #{@admin_1.name}, you are logged in!")
    end
  end

  it "I see a failed log in message if I submit an invalid password" do

    visit "/login"

    fill_in :email, with: @user.email
    fill_in :password, with: 'incorrect'

    click_on "Log In"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it "I see a failed log in message if I submit an invalid email" do

    visit "/login"

    fill_in :email, with: "incorrect@aol.com"
    fill_in :password, with: @user.password

    click_on "Log In"

    click_on "Log In"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  describe "As a logged-in user, merchant, or admin, when I visit the login path" do
    describe "As a regular user" do
      it "redirects to my profile page" do

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit "/login"

        expect(current_path).to eq("/profile")
        expect(page).to have_content("You are already logged in")
      end
    end

    describe "As a merchant user" do
      it "redirects to my merchant dashboard" do

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
        visit "/login"

        expect(current_path).to eq("/merchant")
        expect(page).to have_content("You are already logged in")
      end
    end

    describe "As a admin user" do
      it "redirects to my admin dashboard" do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)
      visit "/login"

      expect(current_path).to eq("/admin")
      expect(page).to have_content("You are already logged in")
      end
    end
  end
end
