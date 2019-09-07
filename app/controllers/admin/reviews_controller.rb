class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_item_path(@review.item)
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to admin_item_path(@review.item)
  end

  private
  def review_params
    params.require(:review).permit(:comment)
  end
end
