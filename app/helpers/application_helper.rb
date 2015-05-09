module ApplicationHelper
	def authenticate_user_from_token
		if !@current_user
			token = request.headers['token'].presence
			@user = User.find_by(authenticate_token: token.to_s)

			if @user
				@current_user = @user
			else
				render json: {}, status: :unauthorized
			end
		end
	end
end
