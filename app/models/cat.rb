class Cat < ActiveRecord::Base
  include ActiveModel::Validations
  include AttributeUpdater
  has_many :cat_breeds
  has_many :breeds, through: :cat_breeds
  has_many :order_cats
  has_many :orders, through: :order_cats
  has_many :users, through: :orders

  validates :name, length: { minimum: 2, maximum: 32 }
  validates_uniqueness_of :name
  validates :price, presence: true
  validates :description, presence: true



  def availability
    if !retired
      return "Available!"
    else
      "Sold out!"
    end
  end

  def quantity(order_id)
    Order.find(order_id).order_cats.find_by(cat_id: id).quantity
  end

  def monify
    price.to_s.insert(-3, ".").insert(0,"$")
  end
end
