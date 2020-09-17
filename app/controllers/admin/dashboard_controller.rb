class Admin::DashboardController < Admin::BaseController

  def show
  end

  def index
  end

  def merchants_index
    @merchants = Merchant.all
  end

  def merchant_update
    merchant = Merchant.find(params[:merchant_id])
    merchant.update(status: 'Disabled')
    flash[:success] = "#{merchant.name}'s account is now disabled'"
    redirect_to '/admin/merchants'
  end
end
