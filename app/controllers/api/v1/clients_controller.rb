class Api::V1::ClientsController < ApplicationController
  before_action :check_admin, only: [:destroy]
  before_action :set_client, only: [:show, :update, :destroy]

  def index
    @clients = Client.availables
    render json: ClientBlueprint.render(@clients, view: :basic)
  end

  def show
    render json: ClientBlueprint.render(@client, view: :client_orders)
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      render json: ClientBlueprint.render(@client, view: :basic), status: :created
    else
      render json: { error: @client.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @client.update(client_params)
      render json: ClientBlueprint.render(@client, view: :basic)
    else
      render json: { error: @client.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @client.update(deleted_at: Time.zone.now)
      render json: { message: 'Deleted' }, status: :ok
    else
      render json: { error: @client.errors.messages }, status: :unprocessable_entity
    end
  end

  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(
          :identification,
          :full_name,
          :phone,
          :email
      )
    end
end