class Review < ApplicationRecord

  VALID_RATINGS = 1..5

  belongs_to :user
  belongs_to :professor
  belongs_to :subject

  validates :user_id, uniqueness: {scope: [:professor_id, :subject_id]}
  validates :rating,  inclusion: {in: VALID_RATINGS}
end
