class Api::AccountsController < ApplicationController
    # ユーザー登録
    def create
        @user = User.new(user_params)  # インスタンスを生成
        @user.save!  # インスタンスをデータベースに保存
        render 'api/me/accounts/show'  # 結果を返す
    end

    private

    def user_params
        params.permit(:name, :email, :password, :password_confirmation)
    end
end
