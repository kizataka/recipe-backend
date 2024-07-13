class Api::DishesController < ApplicationController
    before_action :authenticate, only: %i[create update destroy]
    PER_PAGE = 10

    def index
        if params[:user_id]
            @dishes = Dish.where(user_id: params[:user_id]).includes(:user).order(created_at: :desc).page(params[:page]).per(PER_PAGE)
        else
            @dishes = Dish.includes(:user).order(created_at: :desc).page(params[:page]).per(PER_PAGE)
        end
    end

    def show
        @dish = Dish.find(params[:id])
    end

    def create
        @dish = current_user.dishes.create!(dish_params)
        render :show
    end

    def update
        @dish = current_user.dishes.find(params[:id])
        @dish.update!(dish_params)
        render :show
    end

    def destroy
        @dish = current_user.dishes.find(params[:id])
        @dish.destroy!
        render :show
    end

    private

    def dish_params
        # params.permit(:title, :description, :image)
        params.permit(:title, :description)
    end
end
