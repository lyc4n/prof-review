class Subject < ApplicationRecord
  self.per_page = 20

  validates :code, uniqueness: true, presence: true

  has_and_belongs_to_many :professors

end
