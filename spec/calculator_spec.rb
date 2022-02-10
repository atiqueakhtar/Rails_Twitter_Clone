require './lib/calculator'
require 'rails_helper'
describe Calculator do
    describe "#add" do
      it "returns the sum of two numbers" do
        calculator = Calculator.new
        expect(calculator.add(5, 2)).to eql(7)
      end
    end
    describe "#subtract" do
      it "returns the sum of two numbers" do
        calculator = Calculator.new
        expect(calculator.subtract(5, 2)).to eql(3)
      end
    end
end