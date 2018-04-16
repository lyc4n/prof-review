puts '= Starting seed...'
puts 'Creating admin user...'
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

puts 'Creating users...'
users = FactoryBot.create_list(:user, 10)

puts 'Creating professors...'
professors = FactoryBot.create_list(:professor, 25)

puts 'Creating subjects...'
subjects = FactoryBot.create_list(:subject, 50)

professors.each do |prof|
  puts "Connecting professor #{prof.id} to random subjects and writing reviews..."
  random_subjects = subjects.sample(10)
  prof.subjects = random_subjects

  random_users = users.sample(3)
  random_subjects.each do |subject|
    random_users.each do |reviewer|
      review = Review.create!(subject: subject,
                    professor: prof,
                    user: reviewer,
                    rating: Review::VALID_RATINGS.to_a.sample,
                    description: Faker::Lorem.paragraph(3))
    end
  end
end

puts 'Done seeding!'
