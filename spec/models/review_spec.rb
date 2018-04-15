require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Associations' do
    it{is_expected.to belong_to(:user)}
    it{is_expected.to belong_to(:professor)}
    it{is_expected.to belong_to(:subject)}
  end

  describe 'Validations' do
    it{is_expected.to validate_uniqueness_of(:user_id).scoped_to(:professor_id, :subject_id)}
    it{is_expected.to validate_inclusion_of(:rating).in_range(Review::VALID_RATINGS)}
  end
end
