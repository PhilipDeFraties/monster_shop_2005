class Merchant::DashboardController < Merchant::BaseController

  def show
    @orders = Order.where(status: :pending).joins(:items).where(items: {merchant_id: current_user.merchant.id})
  end

end
