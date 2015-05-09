# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(
	email: 'user@example.com',
	password: '123'
)

5.times do |n|
	User.create!(
		email: "example-#{n}@mail.org",
		password: '123'
	)
end

users = User.all

15.times do
	Task.create!(
		description: 'Buy milk',
		user_id: users.ids.shuffle.first,
		performer: users.shuffle.first.email
	)
end

puts '**DONE**'