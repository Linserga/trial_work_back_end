class TodoController < WebsocketRails::BaseController
	def initialize_session
	end

	def index

		@user = User.find_by(id: message)
		# byebug
		if @user
          WebsocketRails[:tasks].trigger 'change', @user.tasks.to_json
		  send_message :tasks, @user.tasks.to_json	
		end		
	end

	def destroy
		# byebug
		@task = Task.find_by(id: message[:id])
		@task.destroy				
	end
end
