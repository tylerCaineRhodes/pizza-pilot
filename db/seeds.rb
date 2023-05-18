toppings = [
  { name: "Pepperoni", calories: 50 },
  { name: "Mushrooms", calories: 20 },
  { name: "Onions", calories: 10 },
  { name: "Sausage", calories: 60 },
  { name: "Bacon", calories: 42 },
  { name: "Extra cheese", calories: 75 },
  { name: "Black olives", calories: 33 },
  { name: "Green peppers", calories: 10 },
  { name: "Pineapple", calories: 30 },
  { name: "Spinach", calories: 5 }
]
pizzas = ["Margherita", "Pepperoni", "BBQ Chicken", "Hawaiian", "Veggie"]

toppings.each { |topping| Topping.create(topping) }
pizzas.each { |pizza_name| Pizza.create(name: pizza_name) }

memo = Hash.new { |hash, key| hash[key] = [] }

Pizza.all.each do |pizza|
  while pizza.toppings.count < 3
    new_topping = Topping.all.sample
    next if memo[pizza.id].include?(new_topping.id)

    memo[pizza.id] << new_topping.id
    pizza.add_topping(new_topping)
  end
end
