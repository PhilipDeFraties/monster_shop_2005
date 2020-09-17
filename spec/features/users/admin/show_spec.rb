require 'rails_helper'

describe 'As an admin user' do
  describe 'When I visit my admin dashboard ("/admin")' do
    before :each do
      @order = create(:order)
      @admin = create(:admin_user)
      @item_orders = create_list(:item_order, 3)

      visit '/login'

      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password

      click_on "Log In"
    end

    it "I see all orders in the system" do
      expect(current_path).to eq("/admin")

      within "#admin-orders-overview" do
        @item_orders.each do |item_order|
          expect(page).to have_link(item_order.order.user.name)
          expect(page).to have_content(item_order.order.id)
          expect(page).to have_content(item_order.order.created_at.strftime("%m/%d/%y"))
        end
      end
    end
  end
end
