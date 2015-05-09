require 'rails_helper'

RSpec.describe Api::TasksController, type: :controller do

	let(:user) { FactoryGirl.create(:user)}

	before {
		controller.instance_variable_set(:@current_user, user)
	}

	context 'Index' do
		it 'renders json' do
			get :index, user_id: user
			parsed = JSON.parse(response.body)
			expect(parsed[0]['description']).to eq('Buy milk')
		end
	end

	context 'Create' do
		it 'creates new task' do
			expect do
				post :create, { user_id: user.id, task: { description: 'Sample', performer: 'ex@m.com'}}
			end.to change(Task, :count).by(1)
		end
	end

	context 'Update' do
		it 'updates the task' do
			task = user.tasks.first
			task.description = 'MM'

			patch :update, {user_id: user.id, id: task.id, task: { description: task.description, performer: task.performer }}

			task.reload

			expect(task.description).to eq('MM')
		end
	end

	context 'Destroy' do
		it 'deletes task' do
			expect do
				delete :destroy, user_id: user.id, id: user.tasks.first.id
			end.to change(Task, :count).by(-1)
		end
	end
end
