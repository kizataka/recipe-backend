class Api::Me::AccountsController < ApplicationController
    before_action :authenticate  # リクエストが認証済みかどうかを確認

    def update
        @user = current_user  # ログインしているユーザーを取得
        @user.update!(user_params)  # データを更新、保存
        render :show
    end

    private

    def user_params
        params.permit(:name, :email, :password, :password_confirmation)
    end
end
