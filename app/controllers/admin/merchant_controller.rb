class Admin::MerchantController < Admin::BaseController

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @orders = Order.where(status: :pending).joins(:items).where(items: {merchant_id: @merchant.id}).distinct
  end
end
