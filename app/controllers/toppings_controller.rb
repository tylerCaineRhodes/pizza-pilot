class ToppingsController < ApplicationController
  before_action :set_topping, only: %i[show edit update destroy]

  def index
    @toppings = Topping.all
  end

  def show; end

  def new
    @topping = Topping.new
  end

  def edit; end

  def create
    @topping = Topping.new(topping_params)

    existing_topping = Topping.find_by(name: @topping.name)

    if existing_topping
      return redirect_to existing_topping, notice: "This topping already exists."
    end

    if @topping.save
      redirect_to @topping, notice: "Topping was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @topping.update(topping_params)
      redirect_to @topping, notice: "Topping was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @topping.destroy
    redirect_to toppings_url, notice: "Topping was successfully destroyed."
  end

  private

  def set_topping
    @topping = Topping.find(params[:id])
  end

  def topping_params
    params.require(:topping).permit(:name, :calories)
  end
end
