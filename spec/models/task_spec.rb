require 'rails_helper'

RSpec.describe Task, type: :model do
  
  let(:task) {FactoryGirl.create(:task)}

  subject { task }

  it { should be_valid }
  its(:state){ should eq(false)}

  context 'it should not be valid without description' do
  	before { task.description = ''}

  	it { should be_invalid }
  end

  context 'it should not be valid without user' do
  	before { task.user_id = nil }

  	it { should be_invalid }
  end
end
