require 'faker'

puts "Seeding Groups"

Language.all.each do |lang|
  group = Group.new(name: Faker::Hacker.say_something_smart, full: false)
  group.save
end
