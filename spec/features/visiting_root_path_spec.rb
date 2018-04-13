require 'rails_helper'

RSpec.feature 'Visiting root path', type: :feature do
  let(:user){create(:user)}
  let!(:subjects){ [create(:subject, code: "MATH111"), create(:subject, code: "CS123")] }

  scenario 'Sees list of Subjects when user is logged in' do
    login_as user
    visit root_path

    expect(page).to have_text('Class List')
    expect(page).to have_selector('.subject-list-item', count: 2)
    subjects.each do |subject|
      expect(page).to have_text(subject.code)
    end
  end

  scenario 'Redirected to login page' do
    visit root_path
    expect(page.current_path).to eq(new_user_session_path)
  end
end
