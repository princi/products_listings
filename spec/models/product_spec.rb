require 'rails_helper'

describe Product do


  # Check if the all the values are valid product should be created
  it "will create a product with valid values" do
    product = FactoryGirl.build(:product)
    product.valid?.should be_truthy
  end


  # Check if name is not present product should be invalid
  it "will try to create a product without of name" do
    product = FactoryGirl.build :product, :without_name
    product.valid?.should be_falsey
  end

  it "will try to create a product without description" do
    product = FactoryGirl.build :product, :without_description
    product.valid?.should be_falsey
  end

  it "will try to create a product without price " do
    product = FactoryGirl.build :product, :without_price
    product.valid?.should be_falsey
  end

  it "will create not a product with invalid price" do
    product = FactoryGirl.build :product, :invalid_price
    product.valid?.should be_falsey
  end

  it "will edit a existing product price to nil and product will be invalid" do
    product = FactoryGirl.create(:product)
    product.price = "invalid price"
    product.valid?.should be_falsey
  end

  it "will edit a existing product description to blank product will be invalid" do
    product = FactoryGirl.create(:product)
    product.description = nil
    product.valid?.should be_falsey
  end

  it "will destroy an project and it should not be available in database" do
    product = FactoryGirl.create(:product)
    product.destroy
    product = Product.find_by_id(product.id)
    product.should eq(nil)
  end


end
