class Subject < ApplicationRecord
  validates :code, uniqueness: true, presence: true
end
