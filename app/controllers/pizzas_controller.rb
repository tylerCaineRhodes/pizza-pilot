class PizzasController < ApplicationController
  before_action :set_pizza, except: %i[index new create]

  def index
    @pizzas = Pizza.all
  end

  def show; end

  def new
    @pizza = Pizza.new
  end

  def edit; end

  def create
    @pizza = Pizza.new(pizza_params)

    existing_pizza = Pizza.find_by(name: @pizza.name)

    if existing_pizza
      return redirect_to existing_pizza, notice: "This pizza already exists."
    end

    if @pizza.save
      create_pizza_toppings
      redirect_to @pizza, notice: "Pizza was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    update_pizza_toppings
    if @pizza.update(pizza_params)
      redirect_to @pizza, notice: "Pizza was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pizza.destroy
    redirect_to pizzas_url, notice: "Pizza was successfully destroyed."
  end

  private

  def set_pizza
    @pizza = Pizza.find(params[:id])
  end

  def pizza_params
    params.require(:pizza).permit(
      :name,
      pizza_toppings_attributes: %i[id topping_id _destroy name calories]
    )
  end

  def update_pizza_toppings
    @pizza.toppings = Topping.find(topping_ids)
  end

  def create_pizza_toppings
    topping_ids.each do |topping_id|
      PizzaTopping.create(pizza: @pizza, topping_id:)
    end
  end

  def topping_ids
    @topping_ids ||= params[:pizza][:topping_ids]&.reject(&:blank?)&.map(&:to_i) || []
  end
end
