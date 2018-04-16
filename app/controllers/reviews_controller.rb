class ReviewsController < ApplicationController
  before_action :set_facade, except: :create

  def create
    review = current_user.reviews.create(create_review_params)
    @reviews_facade = ReviewsFacade.new(current_user, review.id)

    respond_to do |format|
      format.json { render :show }
    end
  end

  def update
    @reviews_facade.review.update(review_params)

    respond_to do |format|
      format.json { render :show }
    end
  end

  def destroy
    @reviews_facade.review.destroy

    respond_to do |format|
      format.json { render :show }
    end
  end

  private

  def set_facade
    @reviews_facade = ReviewsFacade.new(current_user, params[:id])
  end

  def create_review_params
    params.require(:review).permit(:professor_id, :subject_id, :rating, :description)
  end

  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
