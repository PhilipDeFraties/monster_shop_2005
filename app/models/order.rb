class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :status

  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user, optional: true

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def item_attributes_update(order)
    order.item_orders.each do |item_order|
      item = Item.find(item_order.item_id)
      item.inventory += item_order.quantity if item_order.status == "fulfilled"
      item_order.update(status: "unfulfilled")
    end
  end
end
