class CategoriesController < ApplicationController
  before_action :authenticate_admin!, only: [:create, :update, :destroy]

  expose(:category, attributes: :category_params)
  expose(:categories)

  def create
    if category.save
      redirect_to admin_categories_path, notice: I18n.t('shared.created', resource: 'Category')
    else
      render :new
    end
  end

  def update
    if category.save
      redirect_to admin_categories_path, notice: I18n.t('shared.updated', resource: 'Category')
    else
      render :edit
    end
  end

  def destroy
    category.destroy!
    redirect_to admin_categories_path, notice: I18n.t('shared.deleted', resource: 'Category')
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
