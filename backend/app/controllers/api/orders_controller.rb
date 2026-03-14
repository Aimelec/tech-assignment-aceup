module Api
  class OrdersController < ApplicationController
    def create
      order = Orders::CreateOrder.with(params: order_params)
      render json: serialize(order), status: :created
    end

    def update
      order = Orders::UpdateOrder.with(id: params[:id], params: order_params)
      render json: serialize(order), status: :ok
    end

    def destroy
      order = Orders::DeleteOrder.of(id: params[:id])
      render json: serialize(order), status: :ok
    end

    private

    def order_params
      params.require(:order).permit(:customer_name, :customer_email, :description, :total_amount, :status).to_h.symbolize_keys
    end
  end
end
