class ProfessorSubjectReviewsSummary < ApplicationRecord

  scope :on_subject, ->(subject){where(subject_id: subject)}

  def readonly?
    true
  end
end
