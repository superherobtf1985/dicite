class Admin::ReviewsController < ApplicationController
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_item_path(@review.item)
  end

  def update

  end

  private
  def review_params
    params.require(:review).permit(:user_id, :item_id, :comment)
  end
end
