SELECT
  professors.id as professor_id,
  reviews.subject_id as subject_id,
  avg(reviews.rating) as average_rating,
  count(reviews.id) as reviews_count
FROM "professors"
LEFT OUTER JOIN "reviews"
  ON "reviews"."professor_id" = "professors"."id"
GROUP BY professors.id, reviews.subject_id
