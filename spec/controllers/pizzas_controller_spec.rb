require "rails_helper"

RSpec.describe PizzasController do
  let(:attributes) do
    { name:, pizza_toppings_attributes: }
  end

  let(:name) { "Tropical Explosion" }
  let(:pizza_toppings_attributes) { [{ topping_id: }] }
  let(:topping_id) { topping.id }
  let(:topping) { Topping.create!(name: "Pineapple", calories: 10) }

  describe "#create" do
    subject { -> { post :create, params: { pizza: attributes } } }

    before do
      expect(PizzaTopping.count).to eq(0)
      expect(Pizza.count).to eq(0)
    end

    context "with valid attributes" do
      it "creates a new pizza" do
        expect { subject.call }.to change(Pizza, :count).by(1)
      end

      it "creates a new pizza topping" do
        expect { subject.call }.to change(PizzaTopping, :count).by(1)
        created_pizza = Pizza.last
        expect(created_pizza.toppings.last).to eq(topping)
      end

      it "returns a success" do
        expect(response).to be_successful
      end

      it "redirects to the pizza" do
        subject.call

        new_pizza = Pizza.find_by(name:)
        expect(response).to redirect_to(pizza_url(new_pizza))
      end
    end

    context "with invalid params" do
      context "when pizza attributes are invalid" do
        let(:name) { nil }

        it "does not create a new pizza" do
          expect { subject.call }.not_to change(Pizza, :count)
        end

        it "does not create a new pizza topping" do
          expect { subject.call }.not_to change(PizzaTopping, :count)
        end
      end

      context "when pizza topping attributes are invalid" do
        let(:topping_id) { nil }

        it "does not create a new pizza" do
          expect { subject.call }.not_to change(Pizza, :count)
        end

        it "does not create a new pizza topping" do
          expect { subject.call }.not_to change(PizzaTopping, :count)
        end

        it "returns an unprocessable entity" do
          subject.call
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "when the pizza already exists" do
        let!(:pizza) { Pizza.create!(attributes) }

        it "does not create a new pizza" do
          expect { subject.call }.not_to change(Pizza, :count)
        end

        it "does not create a new pizza topping" do
          expect { subject.call }.not_to change(PizzaTopping, :count)
        end

        it "redirects to the existing pizza" do
          subject.call
          expect(response).to redirect_to(pizza_url(pizza))
        end
      end
    end
  end

  describe "#update" do
    let(:existing_pizza) do
      Pizza.create!(
        name: "Existing Pizza",
        pizza_toppings_attributes: [
          {
            topping_id: existing_topping.id
          }
        ]
      )
    end
    let(:existing_topping) { Topping.create!(name: "Pineapple", calories: 10) }

    let(:topping_to_add) { Topping.create!(name: "Pepperoni", calories: 50) }
    let(:new_attributes) do
      {
        name: "Updated Pizza",
        pizza_toppings_attributes: [{ topping_id: topping_to_add.id }]
      }
    end

    subject { -> { patch :update, params: { id: existing_pizza.id, pizza: new_attributes } } }

    context "with valid attributes" do
      before { subject.call }

      it "updates the existing pizza" do
        existing_pizza.reload
        expect(existing_pizza.name).to eq "Updated Pizza"
      end

      it "updates the pizza topping" do
        existing_pizza.reload
        expect(existing_pizza.toppings.last).to eq(topping_to_add)
      end

      it "redirects to the updated pizza" do
        expect(response).to redirect_to(pizza_url(existing_pizza))
      end
    end

    context "with invalid params" do
      context "when pizza attributes are invalid" do
        let(:new_attributes) { { name: nil, pizza_toppings_attributes: [{ topping_id: topping_to_add.id }] } }

        before { subject.call }

        it "does not update the pizza" do
          existing_pizza.reload
          expect(existing_pizza.name).not_to be_nil
        end

        it "returns an unprocessable entity" do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
