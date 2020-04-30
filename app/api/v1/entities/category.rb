# frozen_string_literal: true

module V1
  module Entities
    class Category < Grape::Entity
      expose :id
      expose :name
      expose :description
    end
  end
end
