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


end
