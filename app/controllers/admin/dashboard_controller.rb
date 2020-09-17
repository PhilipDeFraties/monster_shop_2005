class Admin::DashboardController < Admin::BaseController

  def show
    @orders = Order.all
  end

  def index
  end

end
