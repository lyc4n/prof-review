class ProfessorShowFacade

  attr_reader :professor, :subjects, :subject_review_summaries
  delegate :full_name, :average_rating, :reviews_count, to: :@professor

  def initialize(id)
    @professor = Professor.include_overall_rating_summary.find(id)
    @subject_review_summaries = extract_review_summaries
    @subjects = @professor.subjects
  end

  def average_rating_on_subject(subject)
    if summary = @subject_review_summaries[subject.id]
      summary.average_rating.round(1)
    else
      nil
    end
  end

  def review_count_on_subject(subject)
    if summary = @subject_review_summaries[subject.id]
      summary.reviews_count
    else
      nil
    end
  end

  private

  def extract_review_summaries
    ProfessorSubjectReviewsSummary.
      where(professor_id: @professor).inject({}) do |summaries, summary|

      summaries[summary.subject_id] = summary
      summaries
    end

  end
end
