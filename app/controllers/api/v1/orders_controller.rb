class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index show create]

  # GET orders/
  def index
    render json: OrderSerializer.new(current_user.orders).serializable_hash.to_json
  end

  # GET /orders/1
  def show
    order = current_user.orders.find(params[:id])
    if order
      options = { include: [:products] }
      render json: OrderSerializer.new(order, options).serializable_hash.to_json
    else  
      head 404
    end
  end

  # POST /orders
  def create
    order = current_user.orders.build(order_params)
    if order.save
      OrderMailer.send_confirmation(order).deliver
      render json: order, status: 201
    else
      render json: { errors: order.errors }, status: 422
    end
  end

  private
    def check_login
      head :forbidden unless self.current_user
    end

    def order_params
      params.require(:order).permit(:total, product_ids: [])
    end
end
