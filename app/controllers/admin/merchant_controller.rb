class Admin::MerchantController < Admin::BaseController

  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(status: 'Disabled')
    flash[:success] = "#{merchant.name}'s account is now disabled'"
    redirect_to '/admin/merchant'
  end

  def show
    @merchant = Merchant.find(params[:id])
    @orders = Order.where(status: :pending).joins(:items).where(items: {merchant_id: @merchant.id}).distinct
  end
end
