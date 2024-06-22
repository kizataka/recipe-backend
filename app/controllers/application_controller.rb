class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    class AuthenticationError < StandardError; end

    rescue_from ActiveRecord::RecordNotFound, with: :render404
    rescue_from ActiveRecord::RecordInvalid, with: :render422
    rescue_from AuthenticationError, with: :not_authenticated

    def authenticate
        raise AuthenticationError unless current_user
    end

    def current_user
        @current_user ||= Jwt::UserAuthenticator.call(request.headers)
    end

    private

    def render404(exception)
        render json: { error: { messages: exception.message } }, status: :not_found
    end

    def render422(exception)
        render json: { error: { messages: exception.record.errors.full_messages } }, status: :unprocessable_entity
    end

    def not_authenticated
        render json: { error: { messages: ['ログインしてください'] } }, status: :unauthorized
    end
end
