class Merchant::DashboardController < Merchant::BaseController

  def show
    #if current_user = merchant, look up merchant via merchant id:
     @merchant = Merchant.find(current_user.merchant_id)
    #elsif current_user = amin, look up merchant via params[:merchant_id]
    # @merchant = Merchant.find(params[:merchant_id])
    @orders = Order.where(status: :pending).joins(:items).where(items: {merchant_id: current_user.merchant.id}).distinct
  end

end
