require 'rails_helper'

RSpec.describe 'Cart creation' do
  describe 'When I visit an items show page' do

    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      visit "/items/#{@paper.id}"
      click_on "Add To Cart"
      visit "/items/#{@paper.id}"
      click_on "Add To Cart"
      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"
    end

    it "I see a link to decrease the quantity of item by 1" do
      visit "/cart"
      expect(page).to have_content("-")
    end

    it "I can click the link and it decreases the amount by 1" do
      visit "/cart"

      within 'nav' do
        expect(page).to have_content("Cart: 3")
      end

      click_on("-", :match => :first)

      within 'nav' do
        expect(page).to have_content("Cart: 2")
      end
    end

    it "I can click the link and it decreases the amount by 1 until that item count reaches 0" do
      visit "/cart"

      click_on("-", :match => :first)

      within 'nav' do
        expect(page).to have_content("Cart: 2")
      end

      click_on("-", :match => :first)

      within 'nav' do
        expect(page).to have_content("Cart: 1")
      end

      click_on("-", :match => :first)

      within 'nav' do
        expect(page).to have_content("Cart: 1")
      end
    end
  end
end
