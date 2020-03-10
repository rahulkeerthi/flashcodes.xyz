require 'faker'

puts "SEEDING NOTIFICATIONS"

User.all.each do |user|
  5.times do
    Notification.create!(actor: user, recipient: (User.all).sample, content: Faker::Hacker.say_something_smart)
  end
end
