class ProfessorsIndexFacade
  attr_reader :professors, :subject

  delegate :total_entries, :per_page, :total_pages, :current_page, to: :@professors

  def initialize(current_user, subject_id, page)
    @subject      = Subject.find(subject_id)
    @professors   = @subject.professors.paginate(page: page)
    @current_user = current_user
  end

  def subject_code
    @subject.code
  end

  def current_user_reviews
    @current_user_reviews ||= Review.where(user: @current_user,
                                             subject: @subject,
                                             professor: @professors)
  end

  def reviews_summaries
    @reviews_summaries ||= ProfessorSubjectReviewsSummary.where(subject_id: @subject,
                                                                  professor_id: @professors)
  end
end
