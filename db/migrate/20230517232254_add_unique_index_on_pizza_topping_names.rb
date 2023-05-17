class AddUniqueIndexOnPizzaToppingNames < ActiveRecord::Migration[7.0]
  def up
    add_index :pizza_toppings, %i[pizza_id topping_id], unique: true, name: "idx_pizza_toppings_on_pizza_id_topping_id"
  end

  def down
    remove_index(:pizza_toppings, name: "idx_pizza_toppings_on_pizza_id_topping_id")
  end
end
