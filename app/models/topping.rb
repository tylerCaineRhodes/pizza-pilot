class Topping < ApplicationRecord
  has_many :pizza_toppings, dependent: :destroy
  has_many :pizzas, through: :pizza_toppings

  validates :name, presence: true, uniqueness: true
  validates :calories, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def healthiness
    case calories
    when 0..50
      "healthy"
    when 51..100
      "moderately healthy"
    else
      "unhealthy"
    end
  end
end
