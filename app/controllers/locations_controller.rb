class LocationsController < ApplicationController
  before_action :set_location, only: [:show]

  # GET /locations
  def index

    @locations = Location.where(user_id: params[:user_id])

    render json: @locations
  end

  # GET /locations/1
  def show

    render json: @location

  end

  # POST /locations
  def create

    @loc = location_params
    @main_hash = {user_id: params[:user_id] , latitude: @loc[:latitude] , longitude: @loc[:longitude]}

    @result = Location.create(@main_hash)
    
    render json: @result
  end

  # DELETE /locations/1
  def destroy
    Location.destroy(params[:id])
  end

  def deleteAll
    @user_id = params[:user_id]
    Location.destroy_all(user_id: @user_id)
    render json: { id: @user_id}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.where(user_id: params[:user_id] , id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def location_params
      params.require(:location).permit(:latitude, :longitude)
    end
end
