require 'rails_helper'

describe ProductsController do

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end

  it "redirects to the root path upon save" do
    post :create, product: FactoryGirl.attributes_for(:product)
    response.should redirect_to products_path
  end

  it

end
