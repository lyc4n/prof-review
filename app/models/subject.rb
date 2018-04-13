class Subject < ApplicationRecord
  validates :code, uniqueness: true, presence: true

  has_and_belongs_to_many :professors
end
