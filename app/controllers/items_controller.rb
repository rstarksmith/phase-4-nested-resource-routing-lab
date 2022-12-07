class ItemsController < ApplicationController
 rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = user_find
      items = user.items 
    else
      items = Item.all 
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create 
    user = user_find
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  private

  def user_find
    User.find(params[:user_id])
  end

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end
end
