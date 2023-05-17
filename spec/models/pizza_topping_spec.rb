require "rails_helper"

RSpec.describe PizzaTopping do
  let(:pizza) { Pizza.create!(name: "Margherita") }
  let(:topping) { Topping.create!(name: "Pepperoni", calories: 50) }
  let(:pizza_topping) { described_class.new(pizza: pizza, topping: topping) }

  context "validations" do
    context "when all attributes are valid" do
      it "is valid" do
        expect(topping).to be_valid
      end
    end
    context "when some attributes are invalid" do
      context "when pizza is nil" do
        let(:pizza) { nil }
        it "is not valid" do
          expect(pizza_topping).not_to be_valid
        end
      end

      context "when topping is nil" do
        let(:topping) { nil }
        it "is not valid" do
          expect(pizza_topping).not_to be_valid
        end
      end

      context "when the pizza_id and topping_id combination is not unique" do
        before { PizzaTopping.create!(pizza: pizza, topping: topping) }
        it "is not valid" do
          expect(pizza_topping).not_to be_valid
        end
      end
    end
  end
end
