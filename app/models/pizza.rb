class Pizza < ApplicationRecord
  def self.base_calories
    1000
  end

  has_many :pizza_toppings, dependent: :destroy
  has_many :toppings, through: :pizza_toppings

  accepts_nested_attributes_for :pizza_toppings, allow_destroy: true

  validates :name, presence: true, uniqueness: true

  def add_topping(topping)
    toppings << topping unless topping?(topping)
  end

  def topping?(topping)
    toppings.include?(topping)
  end

  def calories
    toppings.sum(:calories) + Pizza.base_calories
  end
end
