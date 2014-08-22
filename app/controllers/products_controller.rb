class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

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

  def show
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: 'Product was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end

    def set_product
      @product = Product.find(params[:id])
    end

end
