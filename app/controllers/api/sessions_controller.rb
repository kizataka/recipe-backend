class Api::SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
            token = Jwt::TokenProvider.call(user_id: user.id)
            render json: { token: }
        else
            render json: { error: { messages: ['メールアドレスまたはパスワードに誤りがあります。']}}, status: :unauthorized
        end
    end
end