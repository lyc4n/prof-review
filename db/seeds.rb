################
# Admin user
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

################
# Normal users
users = FactoryBot.create_list(:user, 10)

################
# Professors
professors = FactoryBot.create_list(:professor, 25)

################
# Subjects
subjects = FactoryBot.create_list(:subject, 50)

################
# Connect professors and subjects
professors.each do |prof|
  random_subjects = subjects.sample(10)
  prof.subjects = random_subjects
end

puts 'Done seeding!'
