require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }
  let(:auth_headers) do
    post user_session_path, params: { user: { email: user.email, password: user.password } }
    {
      'Authorization' => response.headers['Authorization']
    }
  end
  let(:order_params) do
    {
      order: {
        price_amount: "100.0",
        price_currency: "USD",
        receive_currency: "BTC",
        callback_url: "https://example.com/callback",
        cancel_url: "https://example.com/cancel",
        success_url: "https://example.com/success",
        title: "Order title",
        description: "Order description"
      }
    }
  end

  describe "POST /orders" do
    it "creates an order" do
      post "/orders", params: order_params, headers: auth_headers
      expect(response).to have_http_status(:created).or have_http_status(:ok)
      @order_id = JSON.parse(response.body)["id"]
    end
  end

  describe "GET /orders/:id" do
    before(:each) do
      post "/orders", params: order_params, headers: auth_headers
      @order_id = JSON.parse(response.body)["id"]
    end

    it "retrieves the order" do
      get "/orders/#{@order_id}", headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /orders/:id" do
    before(:each) do
      post "/orders", params: order_params, headers: auth_headers
      @order_id = JSON.parse(response.body)["id"]
    end

    it "deletes the order" do
      delete "/orders/#{@order_id}", headers: auth_headers
      expect(response).to have_http_status(:not_found).or have_http_status(:ok)
    end
  end
end
