class UsersController < ApplicationController
	before_action :set_location, only: [:show]

  # GET /locations
  def index

    @locations = User.all

    render json: @locations
  end

  # GET /locations/1
  def show

    render json: @user

  end

  # POST /locations
  def create

    @result = User.create(user_params)

    render json: @result
  end

  # DELETE /locations/1
  def destroy
    User.destroy(params[:id])
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :emailid, :password)
    end
end
