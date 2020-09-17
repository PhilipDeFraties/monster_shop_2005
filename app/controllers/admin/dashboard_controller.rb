class Admin::DashboardController < Admin::BaseController

  def show
  end

  def index
  end

  def merchants_index
    @merchants = Merchant.all
  end
end
