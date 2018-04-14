json.key_format! camelize: :lower

json.data do
  json.array! professors_index.professors, partial: 'professors/professor', as: :professor
end

json.meta do
  json.(professors_index, :per_page, :total_entries, :total_pages, :current_page)
end
