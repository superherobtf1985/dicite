class Admin::ItemsController < ApplicationController
  def index
    @all_ranks = Item.find(Favorite.group(:item_id).order('count(item_id) desc').limit(3).pluck(:item_id))

    if Item.where(artist_id: params[:artist_id]).present?
      @items = Item.where(artist_id: params[:artist_id])
    else
      @items = Item.all
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_items_path
    else
      render :show
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path
  end

  private
  def item_params
    params.require(:item).permit(:jacket_image, :name, :price, :stock, :status, :release_date, :artist_id, :label_id, :genre_id, :status, cds_attributes: [:id, :number, :_destroy, songs_attributes: [:id, :name, :_destroy]])
  end
end
