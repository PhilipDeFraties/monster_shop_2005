require 'rails_helper'

RSpec.describe 'Cart show' do
  describe 'When I have added items to my cart' do
    describe 'and visit my cart path' do
      before(:each) do
        @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
        @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
        visit "/items/#{@paper.id}"
        click_on "Add To Cart"
        visit "/items/#{@tire.id}"
        click_on "Add To Cart"
        visit "/items/#{@pencil.id}"
        click_on "Add To Cart"
        @items_in_cart = [@paper,@tire,@pencil]
      end

      it 'I can empty my cart by clicking a link' do
        visit '/cart'
        expect(page).to have_link("Empty Cart")
        click_on "Empty Cart"
        expect(current_path).to eq("/cart")
        expect(page).to_not have_css(".cart-items")
        expect(page).to have_content("Cart is currently empty")
      end

      it 'I see all items Ive added to my cart' do
        visit '/cart'

        @items_in_cart.each do |item|
          within "#cart-item-#{item.id}" do
            expect(page).to have_link(item.name)
            expect(page).to have_css("img[src*='#{item.image}']")
            expect(page).to have_link("#{item.merchant.name}")
            expect(page).to have_content("$#{item.price}")
            expect(page).to have_content("1")
            expect(page).to have_content("$#{item.price}")
          end
        end
        expect(page).to have_content("Total: $122")

        visit "/items/#{@pencil.id}"
        click_on "Add To Cart"

        visit '/cart'

        within "#cart-item-#{@pencil.id}" do
          expect(page).to have_content("2")
          expect(page).to have_content("$4")
        end

        expect(page).to have_content("Total: $124")
      end

      it 'I see a button to increase quantity the item next to each item' do
        visit "/cart"

        @items_in_cart.each do |item|
          within "#cart-item-#{item.id}" do
            expect(page).to have_link("+")
          end
        end
      end

      describe "When I click the increase quantity button" do
        it "The item quantity is increased by 1" do
          visit "/cart"

          within "#cart-item-#{@paper.id}" do
              click_link("+")
          end

          within "#item-#{@paper.id}-quantity" do
            expect(page).to have_content(2)
          end
        end

        it "I cannot increase item quantity beyond item inventory" do
          visit "/cart"

          within "#cart-item-#{@paper.id}" do
              26.times do
                click_link("+")
              end
          end

          within "#item-#{@paper.id}-quantity" do
            expect(page).to have_content(25)
          end

          expect(page).to have_content("Cannot increase beyond available inventory")
        end
      end
    end
  end

  describe "When I haven't added anything to my cart" do
    describe "and visit my cart show page" do
      it "I see a message saying my cart is empty" do
        visit '/cart'
        expect(page).to_not have_css(".cart-items")
        expect(page).to have_content("Cart is currently empty")
      end

      it "I do NOT see the link to empty my cart" do
        visit '/cart'
        expect(page).to_not have_link("Empty Cart")
      end
    end
  end

  describe "As a visitor" do
    describe "When I have items in my cart, and visit my cart" do
      before(:each) do

        @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
        visit "/items/#{@paper.id}"
        click_on "Add To Cart"
      end

        it "I see information telling me I must register or log in to finish, register and log in are links" do

          visit("/cart")
          expect(page).to have_content("Please register or login to complete checkout!")
          expect(page).to_not have_link("Checkout")

          within "#visitor" do
            click_link("register")
            expect(current_path).to eq("/register")
          end

          visit("/cart")
          within "#visitor" do
            click_link("login")
            expect(current_path).to eq("/login")
          end
        end

        it "If I am logged in, I don't see a message indicating that I need to do so to checkout" do

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

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

          visit("/cart")
          expect(page).to_not have_content("Please register or login to complete checkout!")
        end
    end
  end
end
