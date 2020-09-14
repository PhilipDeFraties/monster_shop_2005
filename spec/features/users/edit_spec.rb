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
        visit '/login'
        fill_in :email, with: @user_1.email
        fill_in :password, with: @user_1.password
        click_on "Log In"
      end

<<<<<<< HEAD
        visit "/login"

        fill_in :email, with: @user_1.email
        fill_in :password, with: @user_1.password

        click_on "Log In"
=======
      it "When I click on the link to edit my profile data I see a form like the registration page" do
>>>>>>> a26f4d6da83efe3cba5cbaa7d60f6d2cded5502c

        expect(current_path).to eq('/profile')
        expect(page).to have_link("Edit Profile")
        click_on("Edit Profile")
        expect(current_path).to eq("/profile/edit")
        expect(page).to have_field(:name, with: "#{@user_1.name}")
        expect(page).to have_field(:address, with: "#{@user_1.address}")
        expect(page).to have_field(:city, with: "#{@user_1.city}")
        expect(page).to have_field(:state, with: "#{@user_1.state}")
        expect(page).to have_field(:zip, with: "#{@user_1.zip}")
        expect(page).to have_field(:email, with: "#{@user_1.email}")
        expect(page).to_not have_field(:password, with: "#{@user_1.password}")
        expect(page).to_not have_field(:password_confirmation, with: "#{@user_1.password_confirmation}")
        fill_in "Address", with: '123 Main Street'
<<<<<<< HEAD
        # fill_in "Address", with: '123 Main Street'

        click_button 'Update Profile'
=======
        click_button "Update Profile"
        expect(current_path).to eq("/profile")
        expect(page).to have_content('123 Main Street')
      end

      it "When I leave a feild blank I receive an error" do

        click_on("Edit Profile")
        fill_in "Address", with: ""
        click_button "Update Profile"
        expect(current_path).to eq("/profile/edit")
        expect(page).to have_content("Address can't be blank")
      end

      it "when I click on the link to edit my password I see a field for password and confirmation" do

        expect(current_path).to eq('/profile')
        expect(page).to have_link("Edit Password")
        click_on("Edit Password")
        expect(current_path).to eq("/profile/edit_password")
        expect(page).to have_field(:password)
        expect(page).to have_field(:password_confirmation)
        fill_in "Password", with: '123'
        fill_in "Password confirmation", with: '123'
        click_on("Update Password")
>>>>>>> a26f4d6da83efe3cba5cbaa7d60f6d2cded5502c
        expect(current_path).to eq("/profile")
        expect(page).to have_content("#{@user_1.name}, your password has been updated!")
      end

      it "if password doesn't match password confirmation there is an error" do

        click_on("Edit Password")
        fill_in "Password", with: '123'
        fill_in "Password confirmation", with: '321'
        click_on("Update Password")
        expect(current_path).to eq("/profile/edit_password")
        expect(page).to have_content("Passwords must match")
      end

      it "requires a unique email address" do
        user_2 = User.create(
          name: 'Other Gates',
          address: '1000 Microsoft Drive',
          city: 'Seattle',
          state: 'WA',
          zip: '00123',
          email: 'other.gates@outlook.com',
          password: '@%)abc123#$.',
          role: 0
        )

        click_on("Edit Profile")
        fill_in "Email", with: "other.gates@outlook.com"
        click_button "Update Profile"
        expect(current_path).to eq("/profile/edit")
        expect(page).to have_content("Email has already been taken")
      end
    end
  end

end
