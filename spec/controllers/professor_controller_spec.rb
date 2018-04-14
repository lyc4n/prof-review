require 'rails_helper'

RSpec.describe ProfessorsController, type: :controller do
  render_views

  describe 'GET index' do

    before do
      @subject = create(:subject, :with_professor, professors_count: 10)
      expect(@subject.professors.length).to eq(10)
      sign_in create(:user)
    end

    context 'when html' do
      before do
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

    context 'when json' do
      before do
        get :index, params: {subject_id: @subject.id}, format: :json
      end

      it 'renders correct json response' do
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['data'].length).to eq 10
        parsed_response['data'].each do |data|
          expect(Professor.find_by(id: data['id'])).to_not be_nil
        end
        expect(parsed_response['meta']['perPage']).to eq 30
        expect(parsed_response['meta']['totalEntries']).to eq 10
        expect(parsed_response['meta']['totalPages']).to eq 1
        expect(parsed_response['meta']['currentPage']).to eq 1
      end
    end
  end
end
