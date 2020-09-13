require 'rails_helper'

RSpec.describe "Logging In" do
  describe "As a registered user" do
    describe "When I visit my profile page I see a link to edit my profile data" do
      before :each do
        @user_1 = User.create(
          name: 'Bill Gates',
          address: '1000 Microsoft Drive',
          city: 'Seattle',
          state: 'WA',
          zip: '00123',
          email: 'bill.gates@outlook.com',
          password: '@%)abc123#$.',
          role: 0
        )
      end
      it "When I click on the link to edit my profile data I see a form like the registration page" do

        visit '/login'
        fill_in :email, with: @user_1.email
        fill_in :password, with: @user_1.password
        click_on "Log In"

        expect(current_path).to eq('/profile')
        expect(page).to have_link("Edit Profile")
        click_on("Edit Profile")


        expect(current_path).to eq("/profile/#{@user_1.id}/edit")

        expect(page).to have_field(:name, with: "#{@user_1.name}")
        expect(page).to have_field(:address, with: "#{@user_1.address}")
        expect(page).to have_field(:city, with: "#{@user_1.city}")
        expect(page).to have_field(:state, with: "#{@user_1.state}")
        expect(page).to have_field(:zip, with: "#{@user_1.zip}")
        expect(page).to have_field(:email, with: "#{@user_1.email}")
        expect(page).to_not have_field(:password, with: "#{@user_1.password}")
        expect(page).to_not have_field(:password_confirmation, with: "#{@user_1.password_confirmation}")

        fill_in "Address", with: '123 Main Street'

        click_button "Update Profile"
        expect(current_path).to eq("/profile")
        expect(page).to have_content('123 Main Street')
      end

    end
  end

end