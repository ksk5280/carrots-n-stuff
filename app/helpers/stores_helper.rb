module StoresHelper
  def store_save_status(store)
    if @store.save
      flash[:success] = "Store successfully updated."
    else
      flash.now[:danger] = @store.errors.full_messages.join(", ")
    end
  end

  def store_save_edit(store)
    if @store.save
      flash[:success] = "Store successfully updated."
    else
      flash.now[:danger] = @store.errors.full_messages.join(", ")
    end
  end

  def destroy_role_dependents(store)
    ids = User.where(store_id: store.id)
      .joins(:roles)
      .where("roles.name" => ["store_manager", "store_admin"])
      .pluck(:id)
    roles_id = Role.where(name: ["store_manager", "store_admin"]).pluck(:id)
    UserRole.where(user_id: ids, role_id: roles_id).destroy_all
  end

end
