require 'rails_helper'

RSpec.describe Professor, type: :model do
  describe 'Validations' do
    it {is_expected.to validate_presence_of(:first_name)}
    it {is_expected.to validate_presence_of(:last_name)}
  end

  describe 'Associations' do
    it {is_expected.to have_and_belong_to_many(:subjects)}
  end

  describe 'Scopes' do
    describe 'who_teaches' do
      it 'returns professors that are teaching the given subject' do
        subject = create(:subject, :with_professor, professors_count: 5)

        professors = Professor.who_teaches(subject)

        expect(professors).to eq(subject.professors)
      end
    end
  end
end
