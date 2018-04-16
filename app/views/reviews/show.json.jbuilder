json.key_format! camelize: :lower

json.reviews_summary do
  json.extract! @reviews_facade.reviews_summary, :professor_id, :subject_id, :average_rating, :reviews_count
end

json.review do
  json.partial! 'reviews/review', review: @reviews_facade.review
end
