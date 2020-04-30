# frozen_string_literal: true

class Authentications < Grape::API
  namespace :authentications do
    helpers do
      def authenticated
        @user = User.find_by(email: params[:email])
        @user&.valid_password?(params[:password])
      end
    end

    desc 'Authenticate user and retrieve authentication token'
    params do
      requires 'email', type: String
      requires 'password', type: String
    end

    post 'token' do
      error!('401 Unauthorized', 401) unless authenticated

      { api_token: @user.authentication_token }
    end
  end
end
