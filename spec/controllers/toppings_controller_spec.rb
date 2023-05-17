require "rails_helper"

RSpec.describe ToppingsController do
  let(:attributes) { { name: name, calories: calories } }
  let(:name) { "Pineapple" }
  let(:calories) { 10 }

  describe "#create" do
    subject { -> { post :create, params: { topping: attributes } } }

    context "with valid params" do
      it "creates a new Topping" do
        expect(subject).to change(Topping, :count).by(1)
      end

      it "redirects to the created topping" do
        subject.call

        expect(response).to redirect_to(Topping.last)
      end
    end

    context "with invalid params" do
      context "when topping attributes are invalid" do
        context "when name attribute is invalid" do
          let(:name) { nil }
          it "does not create a new Topping" do
            expect(subject).to_not change(Topping, :count)
          end

          it "returns an unprocessable entity" do
            subject.call
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end

        context "when calories attribute is invalid" do
          let(:calories) { -1 }
          it "does not create a new Topping" do
            expect(subject).to_not change(Topping, :count)
          end

          it "returns an unprocessable entity" do
            subject.call
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end

    context "when the topping already exists" do
      let!(:topping) { Topping.create!(attributes) }

      it "does not create a new Topping" do
        expect(subject).to_not change(Topping, :count)
      end

      it "redirects to the existing topping" do
        subject.call

        expect(response).to redirect_to(topping)
      end
    end
  end
end
