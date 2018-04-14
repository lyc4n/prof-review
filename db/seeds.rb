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
FactoryBot.create_list(:subject, 50)

puts 'Done seeding!'
