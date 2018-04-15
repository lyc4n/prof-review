require 'rails_helper'

RSpec.describe Professor, type: :model do
  describe 'Validations' do
    it {is_expected.to validate_presence_of(:first_name)}
    it {is_expected.to validate_presence_of(:last_name)}
  end

  describe 'Associations' do
    it {is_expected.to have_and_belong_to_many(:subjects)}
    it {is_expected.to have_many(:reviews).dependent(:destroy)}
  end
end
