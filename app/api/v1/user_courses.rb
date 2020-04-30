# frozen_string_literal: true

module V1
  class UserCourses < Grape::API
    resource :user_courses do
      desc 'Return list of user courses'
      params do
        optional :available, type: Boolean
        optional :category_id, type: Integer
      end
      get do
        user_courses = current_user.user_courses.includes(:categories, :payment)
        user_courses = UserCourseQuery.new(user_courses, params).execute
        present user_courses, with: V1::Entities::UserCourse
      end

      desc 'Return a specific user course'
      route_param :id do
        get do
          user_course = current_user.user_courses.find(params[:id])
          present user_course, with: V1::Entities::UserCourse
        end
      end
    end
  end
end
