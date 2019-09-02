class EndUser::ReviewsController < ApplicationController
  def create
    @item = Item.find(params[:id])
    comment = current_user.reviews.new(review_params)
    comment.item_id = @item.id
    comment.save
    redirect_to item_path(@item)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to item_path(@review.item)
  end

  private
  def review_params
    params.require(:review).permit(:user_id, :item_id, :comment)
  end
end
