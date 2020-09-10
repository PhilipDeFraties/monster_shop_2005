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
  it "can log in with valid credentials" do
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
