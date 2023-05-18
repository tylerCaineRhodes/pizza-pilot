require "rails_helper"

RSpec.describe Pizza do
  let(:pizza) { described_class.new(name:) }
  let(:topping) { Topping.create(name: "Pepperoni", calories: 50) }
  let(:name) { "Margherita" }
  let(:calories) { 20 }

  describe "validations" do
    context "when all attributes are valid" do
      it "is valid" do
        expect(pizza).to be_valid
      end
    end

    context "when some attributes are invalid" do
      context "when name is nil" do
        let(:name) { nil }

        it "is not valid" do
          expect(pizza).not_to be_valid
        end

        it "has an error on name" do
          pizza.save
          expect(pizza.errors[:name]).to include("can't be blank")
          expect(pizza.errors.count).to eq(1)
        end
      end

      context "when name is an empty string" do
        let(:name) { "" }

        it "is not valid" do
          expect(pizza).not_to be_valid
        end

        it "has an error on name" do
          pizza.save
          expect(pizza.errors[:name]).to include("can't be blank")
          expect(pizza.errors.count).to eq(1)
        end
      end
    end
  end

  describe "#add_topping" do
    context "when the topping is not already on the pizza" do
      it "adds the topping to the pizza" do
        pizza.add_topping(topping)
        expect(pizza.toppings).to include(topping)
      end
    end

    context "when the topping is already on the pizza" do
      it "does not add the topping to the pizza" do
        2.times { pizza.add_topping(topping) }
        expect(pizza.toppings.size).to eq(1)
      end
    end
  end
end
