require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @item_1 = create(:item)
      @item_2 = create(:item)
      @item_3 = create(:item, active?: false)

      @item_order_1 = create(:item_order, quantity: 10)
      @item_order_2 = create(:item_order, quantity: 9)
      @item_order_3 = create(:item_order, quantity: 8)
      @item_order_4 = create(:item_order, quantity: 7)
      @item_order_5 = create(:item_order, quantity: 6)
      @item_order_6 = create(:item_order, quantity: 5)
      @item_order_7 = create(:item_order, quantity: 4)
      @item_order_8 = create(:item_order, quantity: 3)
      @item_order_9 = create(:item_order, quantity: 2)
      @item_order_10 = create(:item_order, quantity: 1)
    end

    describe 'I see an area with statistics' do
      it 'the top 5 most popular items by quantity purchased, plus the quantity bought' do
        expected_items = [@item_order_1.item, @item_order_2.item, @item_order_3.item, @item_order_4.item, @item_order_5.item]

        visit "/items"

        within "#most-popular-items" do
          expected_items.each do |item|
            expect(page).to have_content("#{item.name} #{item.total_bought}")
          end
        end
      end

      it 'the 5 least popular items by quantity purchased, plus the quantity bought' do
        expected_items = [@item_order_10.item, @item_order_9.item, @item_order_8.item, @item_order_7.item, @item_order_6.item]

        visit "/items"

        within "#least-popular-items" do
          expected_items.each do |item|
            expect(page).to have_content("#{item.name} #{item.total_bought}")
          end
        end
      end
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@item_1.name)
      expect(page).to have_link(@item_1.merchant.name)
      expect(page).to have_link(@item_2.name)
      expect(page).to have_link(@item_2.merchant.name)
      expect(page).to_not have_link(@item_3.name)
    end

    it "I can see a list of all of the items "do

      visit '/items'

      within "#item-#{@item_1.id}" do
        expect(page).to have_link(@item_1.name)
        expect(page).to have_content(@item_1.description)
        expect(page).to have_content("Price: $#{@item_1.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@item_1.inventory}")
        expect(page).to have_link(@item_1.merchant.name)
        expect(page).to have_css("img[src*='#{@item_1.image}']")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_link(@item_2.name)
        expect(page).to have_content(@item_2.description)
        expect(page).to have_content("Price: $#{@item_2.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@item_2.inventory}")
        expect(page).to have_link(@item_2.merchant.name)
        expect(page).to have_css("img[src*='#{@item_2.image}']")
      end

      expect(page).to_not have_link(@item_3.name)
      expect(page).to_not have_content(@item_3.description)
      expect(page).to_not have_content("Inactive")
      expect(page).to_not have_content("Inventory: #{@item_3.inventory}")
      expect(page).to_not have_css("img[src*='#{@item_3.image}']")
    end

    describe 'when I am logged in as any type of user' do
      before :each do
        @default_1 = create(:user)
        @merchant_1 = create(:merchant_user)
        @admin_1 = create(:admin_user)
        @users = [@default_1, @merchant_1, @admin_1]
      end

      it 'I can visit the items catalog, /items, and see only active items' do
        @users.each do |user|
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

          visit "/items"

          expect(page).to have_link(@item_2.name)
          expect(page).to have_link(@item_1.name)
          expect(page).to_not have_link(@item_3.name)
        end
      end

      it "From the items page, I can click on an item's image and be directed to it's show page" do
        @users.each do |user|
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

          visit "/items"
          find(:xpath, "//a/img[@alt='#{@item_1.name}-image']/..").click
          expect(current_path).to eq("/items/#{@item_1.id}")
        end
      end
    end
  end
end
