require 'rails_helper'

RSpec.feature 'Subject professors page', type: :feature, js: true do
  scenario 'User is able to submit a review on a professor' do
    user = create(:user)
    login_as user, scope: :user

    subject = create(:subject, :with_professor, professors_count: 3)
    visit(subject_professors_path(subject))
    expect(page).to have_css('.professor-list-item', count: 3)
  end
end
