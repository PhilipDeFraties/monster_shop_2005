# As a registered user
# When I visit my profile page
# Then I see all of my profile data on the page except my password
# And I see a link to edit my profile data
require 'rails_helper'

RSpec.describe 'user show page', type: :feature do
  describe 'As a user' do
    before :each do
      @user = User.create(name: 'Jeff Bezos',
                          address: '123 Main Street',
                          city: 'Denver',
                          state: 'CO',
                          zip: '80123',
                          email: 'jbezos@amazon.com',
                          password: 'Hunter2',
                          role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    describe "When I visit my profile page" do
      it "I see all of my profile data on the page except my password" do

        visit '/profile'

        expect(current_path).to eq('/profile')
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user.address)
        expect(page).to have_content(@user.city)
        expect(page).to have_content(@user.state)
        expect(page).to have_content(@user.zip)
        expect(page).to have_content(@user.email)
      end

      it "I see a link to edit my profile data" do
        visit '/profile'

        expect(page).to have_link('Edit Profile')
      end
    end
  end
end
