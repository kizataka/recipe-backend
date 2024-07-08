class Api::AccountsController < ApplicationController
    # ユーザー登録
    def create
        @user = User.new(user_params)  # インスタンスを生成
        # @user.save!  # インスタンスをデータベースに保存
        if @user.save
            render json: @user, status: :created
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:account).permit(:name, :email, :password, :password_confirmation)
    end
end
