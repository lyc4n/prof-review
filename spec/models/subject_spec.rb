require 'rails_helper'

RSpec.describe Subject, type: :model do
  describe 'Validations' do
    it {is_expected.to validate_uniqueness_of :code}
    it {is_expected.to validate_presence_of   :code}
  end
end
