require 'rails_helper'

RSpec.feature 'Top page', type: :feature do
  let(:user){create(:user)}

  scenario 'User redirected to login page when not yet logged in' do
    visit root_path
    expect(page.current_path).to eq(new_user_session_path)
  end

  scenario 'User sees list of Subjects when user is logged in' do
    setup_subjects_and_professors
    login_as user, scope: :user
    visit root_path

    expect(page).to have_text('Class List')
    expect(page).to have_selector('.subject-list-item', count: subjects.length)
    subjects.each do |subject|
      expect(page).to have_text(subject.code)
    end

    first('.subject-list-item').click_link('See Professors')
    expect(page.current_path).to eq(subject_professors_path(subjects[0]))
  end

  def setup_subjects_and_professors
    @professors = create_list(:professor, 5)
    @professors.each_with_index do |prof, index|
      prof.subjects = subjects.sample(3)
      prof.save
    end
  end

  def subjects
    @subjects ||=  [
      create(:subject, code: "MATH111"),
      create(:subject, code: "CS 123"),
      create(:subject, code: "CS 111"),
      create(:subject, code: "Arts 112"),
      create(:subject, code: "PE 001")
    ]
  end
end
