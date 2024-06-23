class Api::RecipesController < ApplicationController
    before_action :authenticate, only: %i[create update destroy]
    PER_PAGE = 10

    def index
        @dishes = Dish.includes(:user).order(created_at: :desc).page(params[:page]).per(PER_PAGE)
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
        params.permit(:title, :description, :image)
    end
end
