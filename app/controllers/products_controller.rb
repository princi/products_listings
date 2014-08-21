class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
      else
        format.html { redirect_to products_path, notice: 'Please send the valid parameters.' }
      end
    end
  end


  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

end
