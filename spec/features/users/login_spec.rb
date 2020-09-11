# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that I am logged in
require 'rails_helper'

RSpec.describe "Logging In" do
  describe "When I log in as a regular user with valid credentials" do
    it "I am redirected to my profile page" do
      user = User.create(name: 'Jeff Bezos',
                          address: '123 Main Street',
                          city: 'Denver',
                          state: 'CO',
                          zip: '80123',
                          email: 'jbezos@amazon.com',
                          password: 'Hunter2')

      visit "/login"

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Log In"

      expect(current_path).to eq("/users/#{user.id}")
      expect(page).to have_content("Welcome, #{user.name}")
    end
  end

  describe "When I log in as a merchant with valid credentials" do
    it "I am redirected to my merchant dashboard page" do
      merchant_1 = User.create(name: 'Bill Gates',
                          address: '1000 Microsoft Drive',
                          city: 'Seattle',
                          state: 'WA',
                          zip: '00123',
                          email: 'bill.gates@outlook.com',
                          password: '@%)abc123#$.',
                          role: 1)

      visit "/login"

      fill_in :email, with: merchant_1.email
      fill_in :password, with: merchant_1.password

      click_on "Log In"

      expect(current_path).to eq("/merchant")
    end
  end

  it "I see a failed log in message if I submit an invalid password or email" do
    user = User.create(name: 'Jeff Bezos',
                        address: '123 Main Street',
                        city: 'Denver',
                        state: 'CO',
                        zip: '80123',
                        email: 'jbezos@amazon.com',
                        password: 'Hunter2')

    visit "/login"

    fill_in :email, with: user.email
    fill_in :password, with: 'incorrect'

    click_on "Log In"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Sorry, your credentials are bad.")

    fill_in :email, with: "incorrect@aol.com"
    fill_in :password, with: user.password

    expect(current_path).to eq("/login")
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end
