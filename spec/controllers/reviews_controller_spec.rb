require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user_1){create(:user)}
  let(:user_2){create(:user)}
  let(:professor){create(:professor)}
  let(:subject){create(:subject, professors: [professor])}

  before do
    sign_in user_1
  end

  describe 'DELETE destroy' do
    context 'when logged in user tries to delete his own review' do
      let!(:review){create(:review, user: user_1, subject: subject, professor: professor)}

      it 'removes the record from the database' do
        expect{delete :destroy, params: {id: review}, format: :json}.
          to change(Review, :count).by(-1)
      end

      it 'is sucessful' do
        delete :destroy, params: {id: review}, format: :json
        expect(response).to be_success
      end
    end

    context 'when logged in user tries to delete other user\'s review' do
      let!(:review){create(:review, user: user_2, subject: subject, professor: professor)}

      it 'raises an error' do
        expect{delete :destroy, params: {id: review}, format: :json}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PUT update' do
    context 'when logged in user tries to update his own review' do
      let!(:review){create(:review, rating: 5, user: user_1, subject: subject, professor: professor)}

      it 'updates the record in the database' do
        put :update, params: {id: review, review: {rating: 1}}, format: :json
        expect(review.reload.rating).to be(1)
      end

      it 'is sucessful' do
        put :update, params: {id: review, review: {rating: 1}}, format: :json
        expect(response).to be_success
      end
    end

    context 'when logged in user tries to update other user\'s review' do
      let!(:review){create(:review, user: user_2, subject: subject, professor: professor)}

      it 'raises an error' do
        expect{put :update, params: {id: review, review: {rating: 1}}, format: :json}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST create' do
    it 'saves a new review record for the current user' do
      expect(user_1.reviews.count).to eq(0)
      post :create, params: {review: {
        professor_id: professor.id,
        subject_id: subject.id,
        rating: 5,
        description: 'Great professor. I learned a ton!'
      }}, format: :json

      expect(user_1.reviews.count).to eq(1)
    end
  end
end
