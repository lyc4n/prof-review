require 'rails_helper'

RSpec.describe ProfessorsController, type: :controller do
  describe "GET index" do
    before do
      @subject = create(:subject, :with_professor, professors_count: 10)
      sign_in create(:user)
      get :index, params: {subject_id: @subject}
    end

    it 'renders the index page' do
      expect(response).to render_template(:index)
    end

    it 'stores correct professors_index to @professors_index' do
      expect(assigns[:professors_index].professors).to eq(@subject.professors)
      expect(assigns[:professors_index].subject_code).to eq(@subject.code)
    end
  end
end
