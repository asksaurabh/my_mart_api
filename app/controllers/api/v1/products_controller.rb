class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update]
  before_action :check_login, only: %i[create]
  before_action :check_owner, only: %i[update]

  # GET /products/1
  def show
    render json: Product.find(params[:id])
  end

  # GET /products
  def index
    render json: Product.all 
  end

  # POST /products/1
  def create
    product = current_user.products.build(product_params)
    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors }, status: :unprocessable_entity
    end
  end

  # PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private
    def product_params
      params.require(:product).permit(:title, :price, :published)
    end

    def check_login
      head :forbidden unless self.current_user
    end

    def check_owner
      head :forbidden unless @product.user_id == current_user&.id
    end

    def set_product
      @product = Product.find(params[:id])
    end

end