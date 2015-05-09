module Api
	class SessionsController < ApplicationController

		before_action :authenticate_user_from_token, only: [:destroy]

		def create
			
			@user = User.find_by(email: params[:email])

			if @user && @user.authenticate(params[:password])
				token = @user.create_authenticate_token

				render json: { user: @user, auth_token: token}
			else
				render nothing: true, status: :unauthorized
			end
		end

		def destroy
			@current_user.update_attribute(:authenticate_token, nil)
			@current_user = nil

			render json: {}
		end
	end
end