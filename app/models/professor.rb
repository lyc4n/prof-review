class Professor < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name,  presence: true

  has_and_belongs_to_many :subjects

  scope :who_teaches, ->(subject){
    joins(:subjects).where(subjects: {id: subject}) }

  accepts_nested_attributes_for :subjects, allow_destroy: true
end
