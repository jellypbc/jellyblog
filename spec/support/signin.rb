module SignIn
  def login(user)
    controller.instance_variable_set(:@current_user, user)
  end

  def is_logged_in?(user)
    controller.current_user == user
  end
end
