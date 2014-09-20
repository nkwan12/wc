class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :exception
  before_filter :authenticate_user_from_token!

  private

  def temp_user
    return User.where("email like ?", "")[0]
  end

  def authenticate_user_from_token!
    token = request.authorization()
    unless token.nil?
      user_id = token.split(":")[0].to_i
      user = User.find(user_id)
      if user && Devise.secure_compare(user.token, token) && DateTime.now < user.token_expr
        sign_in user, store: false
      end
    end
  end
end
