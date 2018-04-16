class CreateProfessorSubjectReviewsSummaries < ActiveRecord::Migration[5.1]
  def change
    create_view :professor_subject_reviews_summaries
  end
end
