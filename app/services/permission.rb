class Permission
  extend Forwardable
  attr_reader :user

  def_delegators :user,
    :admin?,
    :borrower?,
    :lender?

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

  private

    def controller
      @controller
    end

    def action
      @action
    end

    def platform_admin_permissions
      return true if controller == 'homes' && action.in?(%w(show))
    end

    def store_admin_permissions
      return true if controller == 'homes' && action.in?(%w(show))
    end

    def registered_user_permissions
      return true if controller == 'homes' && action.in?(%w(show))
    end

    def guest_user_permissions
      return true if controller == 'homes' && action.in?(%w(show))
      return true if controller == 'user' && action.in?(%w(new))
      true
    end

end
