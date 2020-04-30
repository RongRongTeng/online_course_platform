# frozen_string_literal: true

module Admin
  class CoursesController < BaseController
    before_action :set_course, only: %i[show edit update destroy]

    def index
      @courses = Course.all.includes(:categories)
    end

    def show; end

    def new
      @course = Course.new
    end

    def edit; end

    def create
      @course = Course.new

      if @course.update(course_params)
        set_flash_message
        redirect_to admin_course_path(@course)
      else
        render :new
      end
    end

    def update
      if @course.update(course_params)
        set_flash_message
        redirect_to admin_course_path(@course)
      else
        render :edit
      end
    end

    def destroy
      @course.destroy
      set_flash_message
      redirect_to admin_courses_path
    end

    private

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:title, :description, :url, :currency, :price,
                                     :starts_at, :ends_at, :expiry_period, category_ids: [])
    end
  end
end
