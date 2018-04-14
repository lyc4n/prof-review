class Professor < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name,  presence: true

  has_and_belongs_to_many :subjects

  accepts_nested_attributes_for :subjects, allow_destroy: true
end
