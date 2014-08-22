require 'rails_helper'

describe ProductsController do

  describe "GET #index" do

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

  end

  describe "Post #create" do

    it "redirects to the root path upon save " do
      post :create, product: FactoryGirl.attributes_for(:product)
      response.should redirect_to products_path
    end

    it "product is created if post request contain valid parameters" do
      post :create, product: FactoryGirl.attributes_for(:product)
      expect(assigns(:product)).not_to be_a_new(Product)
    end

    it "product is not created if post request have name blank" do
      post :create, product: FactoryGirl.attributes_for(:product, :without_name)
      expect(assigns(:product)).to be_a_new(Product)
    end

    it "product is not created if post request have no description" do
      post :create, product: FactoryGirl.attributes_for(:product, :without_description)
      expect(assigns(:product)).to be_a_new(Product)
    end

    it "product is not created if post request have no price" do
      post :create, product: FactoryGirl.attributes_for(:product, :without_price)
      expect(assigns(:product)).to be_a_new(Product)
    end

    it "product is not created if post request have invalid price" do
      post :create, product: FactoryGirl.attributes_for(:product, :invalid_price)
      expect(assigns(:product)).to be_a_new(Product)
    end

  end


  describe "Get #show" do

    before(:each) do
      @product = FactoryGirl.create(:product)
    end

    it "renders the show template" do
       xhr :get, :show, :id => @product
      expect(response).to render_template("show")
    end

    it "renders the same product which is clicked" do
       xhr :get, :show, :id => @product
      expect(assigns(:product)).to eq @product
    end

  end

  describe "Delete #destroy" do

    before(:each) do
      @product = FactoryGirl.create(:product)
    end

    it "reduce the product count by 1 on destroy" do
      expect do
        delete :destroy, {:id => @product.to_param}
      end.to change(Product, :count).by(-1)
    end

    it "redirects to products path on destroy" do
      delete :destroy, :id => @product
      response.should redirect_to products_path
    end

  end

  describe "Put #update" do
    before(:each) do
      @product = FactoryGirl.create(:product)
    end

    it "update values of project if valid parameters " do
      put :update, id: @product, product: FactoryGirl.attributes_for(:product, :price=> 35, :description => "description2", :name => "product2")
      @product.reload
      @product.price.should eq(35)
      @product.description.should eq("description2")
      @product.name.should eq("product2")
    end

    it "redirects to products path after update if valid parameters" do
      put :update, id: @product, product: FactoryGirl.attributes_for(:product, :price=> 35, :description => "description2", :name => "product2")
      expect(response).to redirect_to(products_path)
    end

    it "not update product if without price and render edit" do
      put :update, id: @product, product: FactoryGirl.attributes_for(:product, :without_price)
      @product.reload
      @product.price.should_not(nil)
      expect(response).to render_template(:edit)
    end

    it "not update product if price is invalid and render edit" do
      put :update, id: @product, product: FactoryGirl.attributes_for(:product, :invalid_price)
      @product.reload
      @product.price.should_not == "price"
      expect(response).to render_template(:edit)
    end

    it "not update product if without name and render edit" do
      put :update, id: @product, product: FactoryGirl.attributes_for(:product, :without_name)
      @product.reload
      @product.name.should_not(nil)
      expect(response).to render_template(:edit)
    end

    it "not update product if without description and render edit" do
      put :update, id: @product, product: FactoryGirl.attributes_for(:product, :without_description)
      @product.reload
      @product.description.should_not(nil)
      expect(response).to render_template(:edit)
    end

  end

end
