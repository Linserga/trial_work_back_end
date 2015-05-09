FactoryGirl.define do
  factory :user do
    email "user@example.com"
		password "123"

		after(:create) do |user, evaluator|
			create_list(:task, 2, user: user)
		end
  end

  factory :task do
  	description 'Buy milk'
    performer 'example@mail.com'
  	user
  end

end
