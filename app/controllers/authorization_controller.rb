class AuthorizationController < ApplicationController
  skip_before_filter :authenticate_from_token!

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

  def new_user
    user = User.find_by_email(user_params[:email])
    if user
      respond_to do |format|
        format.json { render json: nil, status: 409 }
      end
    else
      user = User.new({email: user_params[:email]})
      user.password = user_params[:password]
      user.password_confirmation = user_params[:password]
      user.confirm!
      respond_to do |format|
        format.json { render json: {authToken: user.generate_token, userId: user.id}, status: 200 }
      end
    end
  end

  def reset_password
    user = User.find_by_email(user_params[:email])
    status = 204
    if user
      user.send_reset_password_instructions
    else
      status = 404
    end
    respond_to do |format|
      format.json { render json: nil, status: status }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
