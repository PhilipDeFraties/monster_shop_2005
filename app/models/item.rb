class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0


  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def most_popular_items
    # Loop through all items
      # Loop through each order in item
        # Sum the bought quantity for all the orders on that item

    # Item.joins("INNER JOIN t ON t.product_id = products.id")
    #    .from(
    #      Order
    #         .select("orders.product_id, COUNT(orders.id) as count")
    #         .group("orders.product_id").order("count DESC").limit(10),
    #    :t)
    # .order(quantity: :desc).limit(5)
  end
end
