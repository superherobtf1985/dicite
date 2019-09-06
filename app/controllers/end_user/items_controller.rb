class EndUser::ItemsController < ApplicationController
  def index
    @all_ranks = Item.find(Favorite.group(:item_id).order('count(item_id) desc').limit(3).pluck(:item_id))

    if Item.where(artist_id: params[:artist_id]).present?
      @items = Item.where(artist_id: params[:artist_id])
    elsif Item.ransack(params[:q]).present?
      @search = Item.ransack(params[:q])
      @items = @search.result
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @review = Review.new
  end
end
