user1 = User.find_or_initialize_by(email: "crick.lucas@gmail.com")

if user1.new_record?
  user1.password = "carlos"
  user1.name = "Lucas Crick"
  user1.username = user1.name.capitalize.split.join(".").downcase
  user1.birthdate = Date.new(1990, 5, 15)
  user1.phone = "555-1234"
  user1.bio = "Hello! I'm Lucas, a software developer who loves hiking and photography."
  user1.save!
  puts "Created user: #{user1.username}"
else
  puts "Seed user already exists: #{user1.username}"
end
