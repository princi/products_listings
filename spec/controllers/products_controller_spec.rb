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

    it "renders the show template" do
      product = FactoryGirl.create(:product)
       xhr :get, :show, :id => product.id
      expect(response).to render_template("show")
    end

  end

end
