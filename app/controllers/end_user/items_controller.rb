class EndUser::ItemsController < ApplicationController
  def index
    if Item.where(artist_id: params[:artist_id]).present?
      @items = Item.where(artist_id: params[:artist_id])
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @review = Review.new
  end
end
