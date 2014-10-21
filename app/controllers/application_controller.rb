class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :exception
  before_filter :authenticate_user_from_token!, :set_cors_preflight
  after_filter :set_cors_headers
  private

  def temp_user
    return User.where("email like ?", "")[0]
  end

  def authenticate_user_from_token!
    token = request.authorization()
    puts "AUTHENTICATING FROM TOKEN: #{token}"
    unless token.nil? or (%w(null undefined).include? token)
      user_id = token.split(":")[0].to_i
      user = User.find(user_id)
      if user && Devise.secure_compare(user.token, token) && DateTime.now < user.token_expr
        sign_in user, store: false
      end
    end
  end
  
  def authenticate_user_with_exceptions!
    authenticate_user! unless request.method == "OPTIONS" or current_user
  end

  def set_cors_preflight
    if request.method == "OPTIONS" 
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
      render text: ""
    end
  end

  def set_cors_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
