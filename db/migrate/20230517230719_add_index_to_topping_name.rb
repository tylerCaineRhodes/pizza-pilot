class AddIndexToToppingName < ActiveRecord::Migration[7.0]
  def up
    add_index :toppings, :name, unique: true
  end

  def down
    remove_index :toppings, :name
  end
end
