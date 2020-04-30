# frozen_string_literal: true

class Application < Grape::API
  version 'v1', using: :path
  format :json
  prefix :api

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    error!(e.message, 400)
  end

  rescue_from ActiveRecord::RecordNotFound do |_e|
    error!(:not_found, 404)
  end

  rescue_from ::ClientError do |e|
    error!(e.message, 403)
  end

  rescue_from :all do |e|
    raise e if Rails.env.development?

    error!('Internal server error', 500)
  end

  mount Authentications
  mount V1::Base
end
