class AuthorizationController < ApplicationController

  def authorize
    user = User.find_by_email(params[:user_email])
    data = {}
    status = 401
    if user and user.valid_password?(params[:user_password])
      data = {auth_token: user.generate_token}
      status = 200
    end
    respond_to do |format|
     format.json {render json: data, status: status}
    end
  end
end
