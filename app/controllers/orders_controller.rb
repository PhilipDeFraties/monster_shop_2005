class OrdersController < ApplicationController

  def index
  end

  def new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
     unless current_user
       flash[:warning] = "Must log in before checking out"
       render :new
     else
       order = current_user.orders.new(order_params)
       if order.save
         cart.item_orders_create(cart, order)
         session.delete(:cart)
         flash[:success] = "Your order has been created!"
         redirect_to "/profile/orders"
       else
         flash[:notice] = "Please complete address form to create an order."
         render :new
       end
     end
  end

  def destroy
    order = Order.find(params[:id])
    if order.save
      order.item_orders.each do |item_order|
        item = Item.find(item_order.item_id)
        item.inventory += item_order.quantity
        item.save
        item_order.update(status: "unfulfilled")
        item_order.save
      end
      order.update(status: "cancelled")
      flash[:success] = "Your order has been cancelled!"
    else
      flash[:error] = "Unable to cancel this order!"
    end
    redirect_to "/profile/orders"
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
