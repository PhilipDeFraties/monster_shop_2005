require 'rails_helper'

RSpec.describe 'User Registration', type: :feature do
  describe "As a user, when I visit the new user page"
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

      visit '/users/new'
      fill_in :name, with: 'Bill Gates'
      fill_in :address, with: '1000 Microsoft Avenue'
      fill_in :city, with: 'Seattle'
      fill_in :state, with: 'WA'
      fill_in :zip, with: '00123'
      fill_in :email, with: 'bill.gates@outlook.com'
      fill_in :password, with: 'Hunter2'
      fill_in :password_confirmation, with: 'Hunter2'
      click_button 'Create User'
      expect(page).to have_content('Welcome Bill Gates, you are now registered and logged in!')
    end

  it "Reloads with error message if form is submitted with incomplete fields" do
    visit '/users/new'

    fill_in :address, with: '1000 Microsoft Avenue'
    fill_in :city, with: 'Seattle'
    fill_in :state, with: 'WA'
    fill_in :zip, with: '00123'
    fill_in :email, with: 'bill.gates@outlook.com'
    fill_in :password, with: 'Hunter2'
    fill_in :password_confirmation, with: 'Hunter2'
    click_button 'Create User'

    expect(current_path).to eq('/users/new')
    expect(page).to have_content('User not created, all fields must be complete')
  end
end
