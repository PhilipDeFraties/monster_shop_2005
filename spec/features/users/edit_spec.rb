require 'rails_helper'

RSpec.describe "Logging In" do
  describe "As a registered user" do
    describe "When I visit my profile page I see a link to edit my profile data" do
      it "When I click on the link to edit my profile data I see a form like the registration page" do
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

        visit '/profile'
        expect(current_path).to eq('/profile')
        expect(page).to have_link("Edit Profile")
        #which of the following is better?
        #expect(current_path).to eq("/users/edit")
        #check out how edit merchant is setup. it'll be a carbon copy
        expect(current_path).to eq("/users/#{@user_1.id}/edit")


        expect(page).to have_content("Bill Gates")
        expect(page).to have_content("1000 Microsoft Drive")
        expect(page).to have_content("Seattle")
        expect(page).to have_content("WA")
        expect(page).to have_content("bill.gates@outlook.com")
        expect(page).to have_content("@%)abc123#$.")
      end
    end
  end

end
