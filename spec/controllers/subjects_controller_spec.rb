require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  describe "GET index" do
    before do
      sign_in create(:user)
      create_subjects
      get :index
    end

    it 'renders the index page' do
      expect(response).to render_template(:index)
    end

    it 'stores correct subjects to @subjects' do
      expect(assigns[:subjects].all).to eq(@expected_subjects)
    end
  end

  def create_subjects
    @expected_subjects = [
      create(:subject, code: "MATH001"),
      create(:subject, code: "PSY001")]
  end
end
