class AuthorizationController < ApplicationController

  def authorize
    user_params = params[:user]
    user = User.find_by_email(user_params[:email])
    data = {}
    status = 401
    if user and user.valid_password?(user_params[:password])
      data = {authToken: user.generate_token, userId: user.id}
      status = 200
    end
    respond_to do |format|
      format.json {render json: data, status: status}
    end
  end

  def revoke
    authenticate_user_from_token!
    if current_user
      status = 200
      status = 500 unless current_user.revoke_token
      respond_to do |format|
        format.json { render json: nil, status: status }
      end
    else
      respond_to do |format|
        format.json { render json: nil, status: 202 }
      end
    end
  end

  def check_validity
    authenticate_user_from_token!
    if current_user
      respond_to do |format|
        format.json { render json: { userId: current_user.id }, status: 200 }
      end
    else
      respond_to do |format|
        format.json { render json: nil, status: 419 }
      end
    end
  end

end
