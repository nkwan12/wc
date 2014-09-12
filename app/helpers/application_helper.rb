module ApplicationHelper
  def temp_user
    return User.find(4)
  end
end
