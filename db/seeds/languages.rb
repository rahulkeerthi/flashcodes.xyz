#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'faker'
require 'open-uri'

puts "CLEANING DB"
Language.destroy_all

puts "SEEDING LANGUAGES"

f = File.open("db/sourcedata/proglangs.csv", "r")
f.each_line do |line|
  fields = line.split("|")
  lang = Language.new(name: fields[0].tr_s('"', '').strip, description: fields[1].tr_s('"', '').strip)
  file = URI.open(fields[2].tr_s('"', '').strip)
  # binding.pry
  lang.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  begin
    lang.save!
  rescue
    puts "Something wrong with #{fields[0].tr_s('"', '').strip}"
  end
end
