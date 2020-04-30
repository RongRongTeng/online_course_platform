# frozen_string_literal: true

class UserCourseQuery
  def initialize(user_courses, params, now = DateTime.current)
    @user_courses = user_courses
    @params = params
    @now = now
  end

  def execute
    return @user_courses unless @params.present?

    if available_condition
      @user_courses = @user_courses.select { |user_course| user_course.send(available_condition, @now) }
    end

    if category_condition
      @user_courses = @user_courses.select { |user_course| user_course.category_ids.include?(category_condition) }
    end

    @user_courses
  end

  private

  def available_condition
    available = @params[:available]
    return if available.nil?

    available ? :available? : :not_available?
  end

  def category_condition
    category_id = @params[:category_id]
    return if category_id.nil?

    category_id
  end
end
