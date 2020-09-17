class Merchant::DashboardController < Merchant::BaseController

  def show
    @merchant = Merchant.find(current_user.merchant_id)
    @orders = Order.where(status: :pending).joins(:items).where(items: {merchant_id: current_user.merchant.id}).distinct
  end


end
