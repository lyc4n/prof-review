class Professor < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name,  presence: true

  has_and_belongs_to_many :subjects
  has_many :reviews, dependent: :destroy

  scope :include_overall_rating_summary, -> do
    left_outer_joins(:reviews).
    select('professors.*, avg(reviews.rating) as average_rating, count(reviews.id) as reviews_count').
    group('professors.id')
  end

  accepts_nested_attributes_for :subjects, allow_destroy: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
