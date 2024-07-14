class Api::UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
    end

    def me
        render json: current_user
    end
end