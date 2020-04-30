# frozen_string_literal: true

module V1
  module Helpers
    module AuthenticateHelper
      def warden
        env['warden']
      end

      def authenticated
        return true if warden.authenticated?
        return false unless params[:api_token]

        @user = User.find_by(authentication_token: params[:api_token])
      end

      def current_user
        warden.user || @user
      end
    end
  end
end
