require 'rails_helper'

RSpec.describe User, type: :model do

	let(:user){ FactoryGirl.create(:user)}

  subject { user }

  it { should be_valid }

  context 'it should not be valid without email' do
  	before { user.email = ''}

  	it { should be_invalid }
  end

  context 'it should not be valid with email longer than 255 chars' do
  	before { user.email = "a" * 255 + "@example.com"}

  	it { should be_invalid }
  end

  context 'it should not be valid with password less than 2 chars' do
  	before { user.password = "a2" }

  	it { should be_invalid }
  end

  it 'should be valid when email format is correct' do
		addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]

		addresses.each do |address| 
			user.email = address
			expect(user).to be_valid, "#{address.inspect} should be valid"
		end		
	end

	it 'should not be valid when email format is incorrect' do
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]

		invalid_addresses.each do |address|
			user.email = address
			expect(user).not_to be_valid, "#{address.inspect} should be invalid"
		end                           
	end

	it 'emails should be unique' do
		duplicate_user = user.dup
		duplicate_user.email = user.email.upcase
		expect(duplicate_user).to be_invalid
	end
end
