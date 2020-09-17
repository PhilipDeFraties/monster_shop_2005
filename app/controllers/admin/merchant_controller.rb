class Admin::MerchantController < Admin::BaseController

  def show
    @merchant = Merchant.find(params[:merchant_id])
    # binding.pry
    @orders = Order.where(status: :pending).joins(:items).where(items: {merchant_id: @merchant.id}).distinct
    # if current_user.role == "admin"
    #   redirect_to "/admin/merchants/#{@merchant.id}"
    # end
  end
end
