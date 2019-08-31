class EndUser::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])

    if params[:comment_id].present?
      @review = Review.find(params[:review_id])
      render :show
    else
      @review = Review.new
    end
  end
end
