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

    if @result.errors[:emailid].count > 0
    	render json: { msg: "Email has been taken" }
    else
    	render json: @result
    end

  end

  # DELETE /locations/1
  def destroy
    User.destroy(params[:id])
  end

  # POST /locations
  def login
  	@userTest = User.where(emailid: params[:emailid] , password: params[:password])

  	if @userTest.count > 0
  		render json: @userTest[0]
  	else
  		render json: { msg: 'Authentication failed' }
  	end
  end



  def sendNotif
    fcm = FCM.new("AAAA4HIQZe8:APA91bHNAZHr864xlgYJxkrN5es_yo2NbjMj96I9koFwk_P7hk7RcOfyXOeww1_ERjO_hP345K1MzEUwxuMq278201-GfKTZ6z7MI-fPWOc4tZSPNQ8VqXU2a9CJAeCycVNsx3ytJ7C2")
    # registration_ids= ["doZsmvz9xyM:APA91bGtFidRqOPZN7AwiiOhwILnIdXvMLo2lsaP3h57__14szyLMlTUoAX7Dq_8hyLJqBPEOy_aUspidhfUyuOEBa6Ixxee0mWoGecUCH6am94ncfu6lGaBhVXEtdxD3LevIho4QDcp"] # an array of one or more client registration tokens
    # options = {notification: {body: "great match!"}}

    @msg1 = params[:message]

    # options = {data: {score: "123"}, collapse_key: "updated_score"}
    response = fcm.send_to_topic("news", data: {message: @msg1})

    render json: response
    
  end

  def signedInUsers

    @lo = Location.pluck('DISTINCT user_id')
    @uTest = User.where(id: @lo)
    render json: @uTest
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
