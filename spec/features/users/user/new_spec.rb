require 'rails_helper'

describe 'User Registration' do
  describe "As a user, when I visit the new user page" do
    it "I can register a user with a form that has a name, address, city, state, zip, email, and password" do
      visit '/register'

      fill_in "Name", with: 'Jeff Bezos'
      fill_in "Address", with: '123 Main Street'
      fill_in "City", with: 'Denver'
      fill_in "State", with: 'CO'
      fill_in "Zip", with: '80123'
      fill_in "Email", with: 'jbezos@amazon.com'
      fill_in "Password", with: 'Hunter2'
      fill_in "Password confirmation", with: 'Hunter2'

      click_button 'Create User'

      expect(page).to have_content('Welcome Jeff Bezos, you are now registered and logged in!')

      visit '/register'

      fill_in "Name", with: 'Bill Gates'
      fill_in "Address", with: '123 Main Street'
      fill_in "City", with: 'Denver'
      fill_in "State", with: 'CO'
      fill_in "Zip", with: '80123'
      fill_in "Email", with: 'billgates@billgateslovesapple.com'
      fill_in "Password", with: 'Hunter2'
      fill_in "Password confirmation", with: 'Hunter2'

      click_button 'Create User'

      expect(page).to have_content('Welcome Bill Gates, you are now registered and logged in!')
    end

    it "Reloads with error message if form is submitted with incomplete fields" do
      visit '/register'

      fill_in "Address", with: '123 Main Street'
      fill_in "City", with: 'Denver'
      fill_in "State", with: 'CO'
      fill_in "Zip", with: '80123'
      fill_in "Email", with: 'jbezos@amazon.com'
      fill_in "Password", with: 'Hunter2'
      fill_in "Password confirmation", with: 'Hunter2'

      click_button 'Create User'

      expect(current_path).to eq('/users')

      expect(page).to have_content("Name can't be blank")
    end

    describe "When I submit form with an already-in-use email" do
      describe "I am returned to the registration page" do
        describe "My details are not saved and I am not logged in" do
          describe "The form is filled in with all previous data" do
            describe "except the email field and password fields" do
              it "I see a flash message that the email address is already in use" do
                User.create(
                  name: 'Jeff Bezos',
                  address: '123 Main Street',
                  city: 'Denver',
                  state: 'CO',
                  zip: '80123',
                  email: 'jbezos@amazon.com',
                  password: 'Hunter2'
                )

                visit 'register'

                fill_in "Name", with: 'Different Guy'
                fill_in "Address", with: '123 Different Street'
                fill_in "City", with: 'Denver'
                fill_in "State", with: 'CO'
                fill_in "Zip", with: '80123'
                fill_in "Email", with: 'jbezos@amazon.com'
                fill_in "Password", with: 'Hunter2'
                fill_in "Password confirmation", with: 'Hunter2'

                click_button 'Create User'

                expect(current_path).to eq('/users')

                expect(page).to have_content('Email has already been taken')

                expect(page).to_not have_xpath("//input[@value='jbezos@amazon.com']")
                expect(page).to_not have_xpath("//input[@value='Hunter2']")

                expect(page).to have_xpath("//input[@value='Different Guy']")
                expect(page).to have_xpath("//input[@value='123 Different Street']")
                expect(page).to have_xpath("//input[@value='Denver']")
                expect(page).to have_xpath("//input[@value='CO']")
                expect(page).to have_xpath("//input[@value='80123']")
              end
            end
          end
        end
      end
    end
  end
end
