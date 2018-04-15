require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it{is_expected.to validate_presence_of(:first_name)}
    it{is_expected.to validate_presence_of(:last_name)}
  end

  describe 'Associations' do
    it {is_expected.to have_many(:reviews).dependent(:destroy)}
  end
end
