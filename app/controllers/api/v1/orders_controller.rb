class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    @orders = Order.all
    render json: OrderBlueprint.render(@orders, view: :basic)
  end

  def show
    render json: OrderBlueprint.render(@order, view: :order_products)
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      render json: OrderBlueprint.render(@order, view: :order_products), status: :created
    else
      render json: { error: @product.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: OrderBlueprint.render(@order, view: :order_products)
    else
      render json: { error: @product.errors.messages }, status: :unprocessable_entity
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(
        :client_id, 
        :status, 
        :payment_method, 
        order_products_attributes: [
          :id, 
          :product_id, 
          :quantity, 
          :unit_price, 
          :tax_value, 
          :discount_value, 
          :total_products_price,
          :_destroy
        ]
      )
    end
end