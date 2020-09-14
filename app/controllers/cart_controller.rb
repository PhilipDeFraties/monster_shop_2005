class CartController < ApplicationController
  before_action :exclude_admin

  def exclude_admin
    render file: "/public/404" if current_admin?
  end

  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    flash[:success] = "#{item.name} was successfully added to your cart"
    redirect_to "/items"
  end

  def show
    @items = cart.items
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end

  def update
    if cart.item_available?(params[:item_id])
      cart.add_item(params[:item_id])
    else
      flash[:error] = "Cannot increase beyond available inventory"
    end
    redirect_to '/cart'
  end

  def decrease
    item = Item.find(params[:item_id])
    cart.contents["#{item.id}"] -= 1 unless cart.contents["#{item.id}"] == 0
    if cart.contents["#{item.id}"] == 0
      session[:cart].delete(params[:item_id])
    end
    redirect_to '/cart'
  end
end
