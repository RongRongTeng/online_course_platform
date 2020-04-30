# frozen_string_literal: true

module V1
  module Entities
    class UserCourse < Grape::Entity
      expose :id
      expose :expires_at
      expose :is_used
      expose :course, using: V1::Entities::Course
      expose :payment, using: V1::Entities::UserPayment
    end
  end
end
