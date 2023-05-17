class AddUniqueIndexOnPizzaNames < ActiveRecord::Migration[7.0]
  def up
    add_index :pizzas, :name, unique: true
  end

  def down
    remove_index :pizzas, :name
  end
end
