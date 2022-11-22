require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should confirm its a valid product' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Makeup'
      @product.name = 'Eyeliner' 
      @product.price_cents = 10
      @product.quantity = 10000
      @product.category = @category
      expect(@product.valid?).to be true
    end

    it 'should have a valid name' do
      @product = Product.new
      @product.name = nil 
      @product.valid?
        expect(@product.errors[:name]).to include("can't be blank")
  
      @product.name = 'Eyeliner' 
      @product.valid? 
        expect(@product.errors[:name]).not_to include("can't be blank")
    end

    it 'should have a valid price' do
      @product = Product.new
      @product.price_cents = nil 
      @product.valid?
        expect(@product.errors[:price_cents]).to include("is not a number")
  
      @product.price_cents = 10
      @product.valid? 
        expect(@product.errors[:price_cents]).not_to include("is not a number")
    end

    it 'should have a valid quantity' do
      @product = Product.new
      @product.quantity = nil 
      @product.valid?
        expect(@product.errors[:quantity]).to include("can't be blank")
  
      @product.quantity = 10000
      @product.valid? 
        expect(@product.errors[:quantity]).not_to include("can't be blank")
    end

    it 'should have a valid category' do
      @product = Product.new
      @product.category = nil
      @product.valid?
        expect(@product.errors[:category]).to include("must exist")
  
      @product.category = Category.new
      @product.valid? 
        expect(@product.errors[:category]).not_to include("must exist")
    end
  end
end