require 'faker'

puts "DONE! Seeding Groups and Memberships"
puts "CREATING GROUPS"

Language.all.each do |lang|
  group = Group.new(name: "#{Faker::Coffee.blend_name} #{Faker::Creature::Animal.name.capitalize}s", full: false, language:lang)
  group.save
end

puts "GROUPS DONE - CREATING MEMBERSHIPS"

User.first(5).each do |user|
  Group.all.sample(10).each do |group|
    random_points = (rand(1..10) * 10)
    GroupMembership.create(user: user, group: group, points: random_points)
    puts "membership done!"
  end
  random_points = (rand(1..10) * 10)
  user.points = random_points
  user.save
  puts "user done!"
end

puts "ALL DONE! :)"
