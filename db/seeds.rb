FactoryBot.create(:user)
professors = Professor.create([{first_name: 'Pepito', last_name: 'Manoloto'},
                                first_name: 'Huseng', last_name: 'Sisiw'])


codes  = %w{Math Biology Psychology Phys Arts English Filipino NSTP CET}
levels = %w{111 112 113 221 222}

codes.each do |code|
  levels.each do |level|
    Subject.create({code: "#{code} #{level}"})
  end
end

puts 'Done seeding!'
