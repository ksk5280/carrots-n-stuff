class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(slug: params[:slug])
    render file: "public/404" unless @category
  end

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created succesfully."
      redirect_to dashboard_path
    else
      flash.now[:danger] = @category.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @category = Category.find_by(slug: params[:slug])
  end

  def update
    @category = Category.find_by(slug: params[:slug])
    @category.update(category_params)
    if @category.save
      flash[:success] = "Category updated successfully."
      redirect_to dashboard_path
    else
      flash.now[:danger] = @category.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @category = Category.find_by(slug: params[:slug])
    @category.destroy
    flash[:danger] = "Category has been successfully deleted."
    redirect_to dashboard_path
  end

  private

  def category_params
    params.require(:category).permit(:title, :slug)
  end
end
