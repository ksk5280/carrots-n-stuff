class Permission
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def allow?(controller, action)
    @controller = controller
    @action = action

    case @user
    when platform_admin?
      platform_admin_permissions
    when store_admin?
      store_admin_permissions
    when registered_user?
      registered_user_permissions
    else
      guest_user_permissions
    end
  end

  def platform_admin_permissions

  end

  def store_admin_permissions

  end

  def registered_user_permissions

  end

  def guest_user_permissions

  end

end
