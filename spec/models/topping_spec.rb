require "rails_helper"

RSpec.describe Topping do
  let(:topping) { described_class.new(name: name, calories: calories) }
  let(:name) { "Margherita" }
  let(:calories) { 20 }

  context "validations" do
    context "when all attributes are valid" do
      it "is valid" do
        expect(topping).to be_valid
      end
    end

    context "when some attributes are invalid" do
      context "when name is invalid" do
        context "when name is nil" do
          let(:name) { nil }

          it "is not valid" do
            expect(topping).not_to be_valid
          end

          it "has an error on name" do
            topping.save
            expect(topping.errors[:name]).to include("can't be blank")
          end
        end

        context "when name is an empty string" do
          let(:name) { "" }

          it "is not valid" do
            expect(topping).not_to be_valid
          end

          it "has an error on name" do
            topping.save
            expect(topping.errors[:name]).to include("can't be blank")
          end
        end
      end

      context "when calories is invalid" do
        context "when calories is nil" do
          let(:calories) { nil }
          it "is not valid" do
            expect(topping).not_to be_valid
          end

          it "has an error on calories" do
            topping.save
            expect(topping.errors[:calories]).to include("can't be blank")
          end
        end

        context "when calories is less than 0" do
          let(:calories) { -1 }
          it "is not valid" do
            expect(topping).not_to be_valid
          end

          it "has an error on calories" do
            topping.save
            expect(topping.errors[:calories]).to include("must be greater than or equal to 0")
          end
        end
      end
    end
  end
end
