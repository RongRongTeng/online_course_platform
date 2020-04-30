# frozen_string_literal: true

module V1
  module Entities
    class Course < Grape::Entity
      expose :id
      expose :title
      expose :description
      expose :currency
      expose :price
      expose :starts_at
      expose :ends_at
      expose :expiry_period
      expose :categories, using: V1::Entities::Category
    end
  end
end
