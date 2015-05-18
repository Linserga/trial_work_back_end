module Api
	class TasksController < ApplicationController
		
		before_action :authenticate_user_from_token
		before_action :get_user
		
		def index	
            WebsocketRails[:tasks].trigger 'change', Task.where(performer: @user.email).to_json
			render json: Task.where(performer: @user.email)
		end

		def show
			@task = @user.tasks.find_by(id: params[:id])

			render json: @task
		end

		def create
			@task = @user.tasks.build(task_params)

			if @task.save
				render json: {}
			else
				render json: {}, status: :unprocessable_entity
			end
		end

		def update
            @task = @user.tasks.find_by(id: params[:id])

			if @task.update_attributes(task_params)
			  WebsocketRails[:tasks].trigger 'change', Task.where(performer: @user.email).to_json	
              render nothing: true
			else
				render json: {}, status: :internal_server_error
			end
		end

		def destroy
            @task = Task.find_by(id: params[:id])
            @task.destroy
            WebsocketRails[:tasks].trigger 'change', Task.where(performer: @user.email).to_json
            render nothing: true
		end

		private

			def get_user
		      @user = User.find_by(id: params[:user_id])
			end

			def task_params
              params.require(:task).permit(:description, :performer, :state)
			end
	end
end
