#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'faker'

20.times do
  user = User.new(name: "#{Faker::Name.first_name} #{Faker::Name.last_name}", email: Faker::Internet.email, password: "123456", password_confirmation: "123456", bio: Faker::Hacker.say_something_smart)
  user.save
end

CSV.foreach("/sourcedata/proglangs.csv") do |row|
  lang = Language.new(name: row, description: "")
  lang.save
end
