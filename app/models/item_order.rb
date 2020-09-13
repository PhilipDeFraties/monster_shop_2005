class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  def subtotal
    price * quantity
  end

  def self.most_popular_items
    items_hash = ItemOrder.all.group(:item_id).sum(:quantity).sort_by {|item_id, quantity| [-item_id, quantity]}
    result = items_hash.map do |item_id, quantity|
      [Item.find(item_id), quantity]
    end
    binding.pry
  end
end
