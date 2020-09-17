class Admin::MerchantController < Admin::BaseController

  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    merchant.update(status: 'Disabled')
    flash[:success] = "#{merchant.name}'s account is now disabled'"
    redirect_to '/admin/merchants'
  end
end
