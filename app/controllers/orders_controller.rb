class OrdersController < ApplicationController
  def create
    response = HTTParty.post(
      "#{ENV['COINGATE_API_URL']}/v2/orders",
      headers: { 'Authorization' => "Bearer #{ENV['COINGATE_API_TOKEN']}", 'Content-Type' => 'application/json' },
      body: order_params.to_json
    )
    render json: response.parsed_response, status: response.code
  end

  def show
    response = HTTParty.get(
      "#{ENV['COINGATE_API_URL']}/v2/orders/#{params[:id]}",
      headers: { 'Authorization' => "Bearer #{ENV['COINGATE_API_TOKEN']}" }
    )
    render json: response.parsed_response, status: response.code
  end

  def destroy
    response = HTTParty.delete(
      "#{ENV['COINGATE_API_URL']}/v2/orders/#{params[:id]}",
      headers: { 'Authorization' => "Bearer #{ENV['COINGATE_API_TOKEN']}" }
    )
    render json: response.parsed_response, status: response.code
  end

  private

  def order_params
    params.require(:order).permit(:price_amount, :price_currency, :receive_currency, :callback_url, :cancel_url, :success_url, :title, :description)
  end
end
