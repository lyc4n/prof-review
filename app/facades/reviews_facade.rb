class ReviewsFacade
  attr_reader :review

  def initialize(current_user, review_id)
    @review = current_user.reviews.find(review_id)
    @subject   = review.subject
    @professor = review.professor
  end

  def reviews_summary
    @reviews_summary = ProfessorSubjectReviewsSummary.
      find_by(subject_id: @subject, professor_id: @professor)
  end
end
