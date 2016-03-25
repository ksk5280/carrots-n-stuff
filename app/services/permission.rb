class Permission
  attr_reader :user

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action

    case user
    when user.platform_admin?
      platform_admin_permissions
    when user.store_admin?
      store_admin_permissions
    when user.registered_user?
      registered_user_permissions
    else
      guest_user_permissions
    end
  end

  def platform_admin_permissions
    true
  end

  def store_admin_permissions
    true
  end

  def registered_user_permissions
    true
  end

  def guest_user_permissions
    true
  end

end
