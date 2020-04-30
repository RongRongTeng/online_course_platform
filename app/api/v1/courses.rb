# frozen_string_literal: true

module V1
  class Courses < Grape::API
    resource :courses do
      desc 'Return list of courses for sale'
      get do
        courses = Course.for_sale.includes(:categories)
        present courses, with: V1::Entities::Course
      end

      desc 'Return a specific course for sale'
      route_param :id do
        get do
          course = Course.for_sale.find(params[:id])
          present course, with: V1::Entities::Course
        end
      end

      desc 'Purchase a course and return purchase record'
      params do
        requires :course_id, type: Integer
        requires :payment_method, type: String, values: UserPayment.payment_methods.keys
      end
      post 'purchase' do
        course = Course.for_sale.find(params[:course_id])
        user_course = current_user.purchase_course!(course, params[:payment_method])
        present user_course, with: V1::Entities::UserCourse
      end
    end
  end
end
