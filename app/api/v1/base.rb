# frozen_string_literal: true

module V1
  class Base < Grape::API
    helpers V1::Helpers::AuthenticateHelper

    before do
      error!('401 Unauthorized', 401) unless authenticated
    end

    mount V1::Courses
    mount V1::UserCourses
  end
end
