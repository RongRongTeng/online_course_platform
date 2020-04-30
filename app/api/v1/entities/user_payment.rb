# frozen_string_literal: true

module V1
  module Entities
    class UserPayment < Grape::Entity
      expose :id
      expose :payment_method
      expose :currency
      expose :price
      expose :purchased_at
    end
  end
end
