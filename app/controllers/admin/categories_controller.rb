# frozen_string_literal: true

module Admin
  class CategoriesController < BaseController
    before_action :set_category, only: %i[show edit update destroy]

    def index
      @categories = Category.all
    end

    def show
      @category = Category.includes(:courses).find(params[:id])
    end

    def new
      @category = Category.new
    end

    def edit; end

    def create
      @category = Category.new

      if @category.update(category_params)
        set_flash_message
        redirect_to admin_category_path(@category)
      else
        render :new
      end
    end

    def update
      if @category.update(category_params)
        set_flash_message
        redirect_to admin_category_path(@category)
      else
        render :edit
      end
    end

    def destroy
      @category.destroy
      set_flash_message
      redirect_to admin_categories_path
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description, course_ids: [])
    end
  end
end
