class Api::V1::ProductsController < ApplicationController

  # GET /products/1
  def show
    render json: Product.find(params[:id])
  end

  # GET /products
  def index
    render json: Product.all 
  end

end
