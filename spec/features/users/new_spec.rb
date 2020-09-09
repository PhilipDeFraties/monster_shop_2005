require 'rails_helper'

RSpec.describe 'User Registration', type: :feature do
  it "I can register a user with a form that has a name, address, city, state, zip, email, and password" do

    visit '/users/new'
    fill_in :name, with: 'Jeff Bezos'
    fill_in :address, with: '123 Main Street'
    fill_in :city, with: 'Denver'
    fill_in :state, with: 'CO'
    fill_in :zip, with: '80123'
    fill_in :email, with: 'jbezos@amazon.com'
    fill_in :password, with: 'Hunter2'
    fill_in :password_confirmation, with: 'Hunter2'

    click_button 'Create User'
    expect(page).to have_content('Welcome Jeff Bezos, you are now registered and logged in!')
  end
end
