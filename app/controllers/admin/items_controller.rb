class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
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
  end

  private
  def item_params
    params.require(:item).permit(:jacket_image, :name, :price, :stock, :status, :release_date, :artist_id, :label_id, :genre_id, cds_attributes: [:id, :number, :_destroy, songs_attributes: [:id, :name, :_destroy]])
  end
end
