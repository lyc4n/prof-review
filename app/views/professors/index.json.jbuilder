json.key_format! camelize: :lower

json.data do
  json.array! professors_index.professors, partial: 'professors/professor', as: :professor
end

json.subject professors_index.subject, :id, :code

json.reviews_summaries professors_index.reviews_summaries, :professor_id, :subject_id, :average_rating, :reviews_count

json.current_user_reviews do
  json.array! professors_index.current_user_reviews, partial: 'reviews/review', as: :review
end

json.meta do
  json.(professors_index, :per_page, :total_entries, :total_pages, :current_page)
end
