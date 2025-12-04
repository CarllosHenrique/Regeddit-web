user1 = User.new
user1.email = "crick.lucas@gmail.com"
user1.password = "carlos"
user1.name = "Lucas Crick"
user1.username = user1.name.capitalize.split.join(".").downcase
user1.birthdate = Date.new(1990, 5, 15)
user1.phone = "555-1234"
user1.bio = "Hello! I'm Lucas, a software developer who loves hiking and photography."
user1.save if user1.exists?
puts "Created user: #{user1.username}"
