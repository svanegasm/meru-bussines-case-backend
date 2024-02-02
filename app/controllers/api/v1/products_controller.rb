class Api::V1::ProductsController < ApplicationController
  before_action :check_admin, except: [:index, :show]
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = Product.availables
    render json: ProductBlueprint.render(@products, view: :list)
  end

  def show
    render json: ProductBlueprint.render(@product, view: :list)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: ProductBlueprint.render(@product, view: :list), status: :created
    else
      render json: { error: @product.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: ProductBlueprint.render(@product, view: :list)
    else
      render json: { error: @product.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
      if @product.update(deleted_at: Time.zone.now)
          render json: { message: 'Deleted' }, status: :ok
      else
          render json: { error: @product.errors.messages }, status: :unprocessable_entity
      end
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :stock, :percentage_discount, :percentage_tax)
    end
end