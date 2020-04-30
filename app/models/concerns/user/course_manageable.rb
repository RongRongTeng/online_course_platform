# frozen_string_literal: true

class User < ApplicationRecord
  module CourseManageable
    extend ActiveSupport::Concern

    included do
      has_many :user_courses, dependent: :restrict_with_exception
    end

    def purchase_course!(course, payment_method, now = DateTime.current)
      available_courses = available_courses_with_id(course.id, now)
      raise ::ClientError, :duplicate_purchased if available_courses.any?

      UserPayment.transaction do
        payment = user_payments.create!(currency: course.currency,
                                        price: course.price,
                                        payment_method: payment_method,
                                        purchased_at: now)

        @user_course = user_courses.create!(course: course, payment: payment)
      end
      @user_course
    end

    private

    def available_courses_with_id(course_id, now = DateTime.current)
      user_courses.where(course_id: course_id).available(now)
    end
  end
end
